# VibeShop DAO setup

This branch contains the DAO layer for the Tomcat 9 version of VibeShop.

## Tomcat 9 rule

Use `javax.servlet.*`, not `jakarta.servlet.*`.

Tomcat 9 supports Java EE / Servlet 4.x APIs. Mixing Tomcat 9 with `jakarta.servlet.*` causes servlet compilation or runtime errors.

## Added Java packages

```text
VibeShop/src/main/java/model/
VibeShop/src/main/java/model/dao/
VibeShop/src/main/java/util/
```

## Database connection

`model.dao.DataSourceProvider` connects to:

```text
jdbc:mysql://localhost:3306/vibeshop
user: vibeshop_app
password: VibeShopApp2026!
```

## Required dependencies

Add the following JAR files to:

```text
VibeShop/src/main/webapp/WEB-INF/lib/
```

Required examples:

```text
mysql-connector-j-8.0.xx.jar
jbcrypt-0.4.jar
```

`jbcrypt-0.4.jar` is required because `util.PasswordUtils` uses `org.mindrot.jbcrypt.BCrypt` for password hashing and verification.

## Current implemented DAO classes

```text
UserDAO
ProductDAO
OrderDAO
ArtistDAO
ConcertoDAO
```

`UserDAO` is wired into `LoginServlet`, `RegisterServlet`, `CheckEmailServlet` and profile-related user operations.

## Registration fields

The registration form sends:

```text
nome
cognome
username
email
telefono
password
confirmPassword
terms
```

`telefono` is optional in the form and is mapped to the `utente.cellulare` database column. `username` is currently validated from the form but is not persisted because the current `utente` table does not include a username column.

## Password handling

Passwords are hashed and verified in Java through bcrypt:

```java
PasswordUtils.hashPassword(plainPassword)
PasswordUtils.verifyPassword(plainPassword, storedHash)
```

The database stores only the bcrypt hash in `utente.password_hash`.

The bcrypt hash already contains:

```text
algorithm marker
cost factor
salt
hash body
```

No separate `salt` column is required.

## Database setup for final demo

Preferred clean import for the final demo:

```text
VibeShop/db/VIBESHOP_BCRYPT_READY.sql
```

This script creates a fresh schema with `utente.password_hash` as `VARCHAR(100)` and clean demo data for artists, concerts and products.

Legacy import flow, if you still use the old dump:

1. Import `VibeShop/db/VIBESHOP.sql`.
2. Run `VibeShop/db/2026_06_21_bcrypt_passwords.sql`.
3. Recreate users through the registration page or reset their passwords, because legacy SHA-256 hashes cannot be verified by bcrypt.

## Demo account setup after bcrypt migration

Recommended demo flow:

1. Import `VibeShop/db/VIBESHOP_BCRYPT_READY.sql`.
2. Add `mysql-connector-j-8.0.xx.jar` and `jbcrypt-0.4.jar` to `WEB-INF/lib`.
3. Register a fresh user through `/jsp/register.jsp`; this creates a bcrypt password hash.
4. To use that user as admin for the demo, run:

```sql
UPDATE utente
SET role = 'ADMIN'
WHERE email = 'replace-with-demo-email@example.com';
```

Do not reuse the old seeded SHA-256 passwords after enabling bcrypt.
