package com.aisolano.demo.Entity;

import com.decsef.auth.manager.entity.AuthUser;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;
import javax.validation.constraints.*;
import java.time.LocalDateTime;

@Entity
@Data
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class User {

    @Id
    private Long id;

    @MapsId
    @OneToOne
    private AuthUser user;

    @Email
    private String email;

    @NotBlank
    private String name = "Nuevo Usuario";

    private String imageURL;

}