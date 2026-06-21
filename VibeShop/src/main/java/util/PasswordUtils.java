package util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for password hashing and verification.
 *
 * Passwords are never stored in plain text. The generated bcrypt hash already
 * contains the algorithm marker, cost factor and salt.
 */
public final class PasswordUtils {

    private static final int BCRYPT_COST = 12;

    private PasswordUtils() {
        // Utility class: do not instantiate.
    }

    public static String hashPassword(String plainPassword) {
        if (plainPassword == null) {
            throw new IllegalArgumentException("Password cannot be null");
        }

        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(BCRYPT_COST));
    }

    public static boolean verifyPassword(String plainPassword, String storedHash) {
        if (plainPassword == null || storedHash == null || storedHash.trim().isEmpty()) {
            return false;
        }

        try {
            return BCrypt.checkpw(plainPassword, storedHash);
        } catch (IllegalArgumentException e) {
            return false;
        }
    }
}
