package com.aisolano.demo.Controller;

import com.aisolano.demo.Entity.User;
import com.aisolano.demo.Service.UserService;
import com.decsef.auth.manager.entity.AuthUser;
import com.decsef.auth.manager.service.AuthService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FilenameUtils;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.Objects;

@Slf4j
@RestController
@RequestMapping("api/user")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private AuthService authService;

    @GetMapping("/info")
    public User getUserInfo(
            @Autowired Authentication authentication) {
        AuthUser authUser = (AuthUser) authentication.getPrincipal();
        return userService.getUser(authUser);
    }

    @GetMapping("/media/{student}/{filename}")
    public ResponseEntity<StreamingResponseBody> mediaGet(
            @PathVariable String student,
            @PathVariable String filename) {
        String path = "./";
        path = path.concat(student) + "/";
        path = path.concat(filename);
        System.out.println(path);
        File photo = new File(path);
        StreamingResponseBody stream = out -> {
            out.write(loadFile(photo));
        };
        return new ResponseEntity<>(stream, HttpStatus.OK);
    }


    @PostMapping("/file")
    public Boolean saveFile(@Autowired Authentication authentication, @RequestParam("file") MultipartFile file) {
        System.out.println(file.getName());
        System.out.println(file.getOriginalFilename());
        System.out.println(file.getSize());
        AuthUser authUser = (AuthUser) authentication.getPrincipal();
        try {

            Path downloadedFile = Paths.get(Objects.requireNonNull(file.getOriginalFilename()));
            Files.copy(file.getInputStream(), downloadedFile);
            Path toDirectory = Paths.get(authUser.getName());
            if (!Files.exists(toDirectory)) {
                Files.createDirectories(toDirectory);
            }
            toDirectory = Paths.get(authUser.getName() + "/" + LocalDateTime.now() + "." + FilenameUtils.getExtension(file.getOriginalFilename()));
            System.out.println(toDirectory.getFileName());
            Files.move(downloadedFile, toDirectory);
            User user = userService.getUser(authUser);
            String imageURL = "/media/".concat(authUser.getName()).concat("/").concat(toDirectory.toString());
            user.setImageURL("http://localhost:9707api/user" + imageURL);
            return true;
        } catch (IOException e) {
            LoggerFactory.getLogger(this.getClass()).error("pictureUpload", e);
            return false;
        }
    }

    private byte[] loadFile(File file) throws IOException {
        FileInputStream is = new FileInputStream(file);

        long length = file.length();
        if (length > Integer.MAX_VALUE) {
            // File is too large
        }
        byte[] bytes = new byte[(int) length];

        int offset = 0;
        int numRead = 0;
        while (offset < bytes.length
                && (numRead = is.read(bytes, offset, bytes.length - offset)) >= 0) {
            offset += numRead;
        }

        if (offset < bytes.length) {
            throw new IOException("Could not completely read file " + file.getName());
        }
        is.close();
        return bytes;
    }
}
