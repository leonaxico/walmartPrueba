package com.aisolano.demo.Service;

import com.aisolano.demo.Entity.User;
import com.aisolano.demo.Payload.SingUpPayload;
import com.aisolano.demo.Repository.UserRepository;
import com.decsef.auth.manager.entity.AuthUser;
import com.decsef.auth.manager.payload.CreateUserRequest;
import com.decsef.auth.manager.payload.CreateUserResponse;
import com.decsef.auth.manager.service.AuthService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;

@Slf4j
@Service
public class UserService {

    @Autowired
    private AuthService authService;

    @Autowired
    private UserRepository userRepository;

    @Transactional
    public CreateUserResponse create(SingUpPayload signUpRequest, String roleNames, Optional<String> fileURL) {
        CreateUserRequest createUserRequest = CreateUserRequest.builder()
                .username(signUpRequest.getMail())
                .password(signUpRequest.getPassword())
                .roles(roleNames)
                .expirationTime(null)
                .build();
        CreateUserResponse createUserResponse = authService.createUser(createUserRequest);
        if (createUserResponse.isSuccess()) {
            AuthUser authUser = authService.getUser(signUpRequest.getMail());
            User user = User.builder()
                    .user(authUser)
                    .email(signUpRequest.getMail())
                    .name(signUpRequest.getUsername())
                    .build();
            if (fileURL.isPresent()){
                user.setImageURL(fileURL.get());
            }
            userRepository.save(user);
        }
        return createUserResponse;
    }

    public User getUser(AuthUser user){
        return userRepository.findById(user.getId()).get();
    }
}
