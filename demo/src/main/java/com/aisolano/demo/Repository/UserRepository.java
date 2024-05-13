package com.aisolano.demo.Repository;

import com.aisolano.demo.Entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.jws.soap.SOAPBinding;

public interface UserRepository extends JpaRepository<User, Long> {
}
