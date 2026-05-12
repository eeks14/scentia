package com.scentia.util;

import java.security.MessageDigest;

public class ValidationUtil {

    public static boolean isValidName(String name) {
        return name != null &&
               name.matches("[a-zA-Z ]+");
    }

    public static boolean isValidEmail(String email) {
        return email != null &&
               email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$");
    }

    public static boolean isValidPassword(String password) {
        return password != null &&
               password.length() >= 6;
    }

    public static String hashPassword(String password)
            throws Exception {

        MessageDigest md =
                MessageDigest.getInstance("SHA-256");

        byte[] hash =
                md.digest(password.getBytes("UTF-8"));

        StringBuilder sb = new StringBuilder();

        for (byte b : hash) {
            sb.append(String.format("%02x", b));
        }

        return sb.toString();
    }
}