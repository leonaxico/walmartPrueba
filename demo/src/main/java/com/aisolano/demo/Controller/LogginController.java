package com.aisolano.demo.Controller;

import com.aisolano.demo.Payload.SingUpPayload;
import com.aisolano.demo.RoleName;
import com.aisolano.demo.Service.UserService;
import com.decsef.auth.manager.payload.CreateUserResponse;
import com.decsef.auth.manager.payload.GenerateTokenRequest;
import com.decsef.auth.manager.payload.GenerateTokenResponse;
import com.decsef.auth.manager.service.AuthService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@Slf4j
@RestController
@RequestMapping("api/loggin")
public class LogginController {
    @Autowired
    private UserService userService;

    @Autowired
    private AuthService authService;

    @PostMapping("/sign-up")
    public ResponseEntity<?> signUp(@Valid @RequestBody SingUpPayload signUpRequest) {
        if (!authService.userExists(signUpRequest.getMail())) {
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
        } else {
            GenerateTokenRequest generateTokenRequest = new GenerateTokenRequest(signUpRequest.getMail(), signUpRequest.getPassword());
            GenerateTokenResponse tokenResponse = authService.generateToken(generateTokenRequest);
            if(tokenResponse.isSuccess()){
                return tokenResponse.isSuccess()
                        ? ResponseEntity.ok(tokenResponse)
                        : ResponseEntity.badRequest().body(tokenResponse);}
            else {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body("Error en las credenciales de usuario");
            }
        }
    }
}
