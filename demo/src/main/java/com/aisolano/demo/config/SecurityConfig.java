package com.aisolano.demo.config;

import com.decsef.auth.manager.annotation.EnableAuthManager;
import com.decsef.auth.manager.configuration.AuthManagerConfigurerAdapter;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true)
@EnableTransactionManagement
@EnableAuthManager

public class SecurityConfig extends AuthManagerConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        // Don't forget call to the configure of the super class
        super.configure(http);

        http.csrf().disable();
        http.cors().disable();

        http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);

        http.authorizeRequests().antMatchers("/sign-up")
                .permitAll();

        http.authorizeRequests().anyRequest().authenticated();
    }
}

