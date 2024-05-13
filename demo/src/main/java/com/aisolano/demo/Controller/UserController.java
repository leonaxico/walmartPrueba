package com.aisolano.demo.Controller;

import com.aisolano.demo.Payload.SingUpPayload;
import com.aisolano.demo.RoleName;
import com.aisolano.demo.Service.UserService;
import com.decsef.auth.manager.entity.AuthUser;
import com.decsef.auth.manager.payload.CreateUserResponse;
import com.decsef.auth.manager.payload.GenerateTokenRequest;
import com.decsef.auth.manager.payload.GenerateTokenResponse;
import com.decsef.auth.manager.service.AuthService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.apache.commons.io.FilenameUtils;

import javax.validation.Valid;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.Objects;

@Slf4j
@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private AuthService authService;

    @PostMapping("/sign-up")
    public ResponseEntity<?> signUp(@Valid @RequestBody SingUpPayload signUpRequest) {
        CreateUserResponse createUserResponse = userService.create(signUpRequest, RoleName.ROLE_USER, null);
        if (createUserResponse.isSuccess()) {
            GenerateTokenRequest tokenRequest = new GenerateTokenRequest(signUpRequest.getMail(),
                    signUpRequest.getPassword());
            GenerateTokenResponse response = authService.generateToken(tokenRequest);
            return response.isSuccess()
                    ? ResponseEntity.ok(response)
                    : ResponseEntity.badRequest().body(response);
        } else {
            return ResponseEntity.badRequest().body(createUserResponse);
        }
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
                System.out.println("Directory is created!");
            }
            toDirectory = Paths.get(authUser.getName() + "/" + LocalDateTime.now() + "." + FilenameUtils.getExtension(file.getOriginalFilename()));
            System.out.println(toDirectory.getFileName());
            Files.move(downloadedFile, toDirectory);
            return true;
        } catch (IOException e) {
            LoggerFactory.getLogger(this.getClass()).error("pictureUpload", e);
            return false;
        }
    }
}
