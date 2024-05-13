package com.aisolano.demo.Service;

import com.aisolano.demo.Entity.User;
import com.aisolano.demo.Payload.SingUpPayload;
import com.decsef.auth.manager.entity.AuthUser;
import com.decsef.auth.manager.payload.CreateUserRequest;
import com.decsef.auth.manager.payload.CreateUserResponse;
import com.decsef.auth.manager.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;

import javax.transaction.Transactional;
import java.util.Optional;

public class UserService {

    @Autowired
    private AuthService authService;

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
        }
        return createUserResponse;
    }
}
