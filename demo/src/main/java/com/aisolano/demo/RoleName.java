package com.aisolano.demo;

import java.util.Arrays;
import java.util.List;

public final class RoleName {

    public static final String ROLE_USER = "ROLE_USER";
    public static final String ROLE_ADMIN = "ROLE_ADMIN";

    public static List<String> list() {
        return Arrays.asList(ROLE_USER, ROLE_ADMIN);
    }
}