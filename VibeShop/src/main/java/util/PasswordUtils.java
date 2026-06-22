package util;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public final class PasswordUtils {

    private static final int BCRYPT_COST = 12;
    private static final String BCRYPT_CLASS = "org.mindrot.jbcrypt.BCrypt";

    private PasswordUtils() {
    }

    public static String hashPassword(String plainPassword) {
        if (plainPassword == null) {
            throw new IllegalArgumentException("Password cannot be null");
        }

        try {
            Class<?> bcrypt = Class.forName(BCRYPT_CLASS);
            Method gensalt = bcrypt.getMethod("gensalt", int.class);
            Method hashpw = bcrypt.getMethod("hashpw", String.class, String.class);
            String salt = (String) gensalt.invoke(null, BCRYPT_COST);
            return (String) hashpw.invoke(null, plainPassword, salt);
        } catch (ClassNotFoundException e) {
            throw new IllegalStateException("jBCrypt library is missing. Add jbcrypt-0.4.jar to WEB-INF/lib.", e);
        } catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException e) {
            throw new IllegalStateException("Unable to generate bcrypt password hash.", e);
        }
    }

    public static boolean verifyPassword(String plainPassword, String storedHash) {
        if (plainPassword == null || storedHash == null || storedHash.trim().isEmpty()) {
            return false;
        }

        try {
            Class<?> bcrypt = Class.forName(BCRYPT_CLASS);
            Method checkpw = bcrypt.getMethod("checkpw", String.class, String.class);
            return Boolean.TRUE.equals(checkpw.invoke(null, plainPassword, storedHash));
        } catch (ClassNotFoundException e) {
            throw new IllegalStateException("jBCrypt library is missing. Add jbcrypt-0.4.jar to WEB-INF/lib.", e);
        } catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException e) {
            return false;
        }
    }
}
