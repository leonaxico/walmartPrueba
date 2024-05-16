package com.aisolano.demo.Entity;

import com.decsef.auth.manager.entity.AuthUser;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

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
    @JsonIgnore
    private AuthUser user;

    @Email
    private String email;

    @NotBlank
    private String name = "Nuevo Usuario";

    private String imageURL;

}