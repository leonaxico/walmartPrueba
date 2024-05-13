package com.aisolano.demo.Payload;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SingUpPayload {

    @NotBlank
    @Email
    private String mail;

    @NotBlank
    private String password;

    @NotBlank
    private String username;
}
