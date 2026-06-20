# VibeShop DAO setup

This branch contains the first DAO layer for the Tomcat 9 version of VibeShop.

## Tomcat 9 rule

Use `javax.servlet.*`, not `jakarta.servlet.*`.

Tomcat 9 supports Java EE / Servlet 4.x APIs. Mixing Tomcat 9 with `jakarta.servlet.*` causes servlet compilation or runtime errors.

## Added Java packages

```text
VibeShop/src/main/java/model/
VibeShop/src/main/java/model/dao/
```

## Database connection

`model.dao.DataSourceProvider` connects to:

```text
jdbc:mysql://localhost:3306/vibeshop
user: vibeshop_app
password: VibeShopApp2026!
```

## Required dependency

Add MySQL Connector/J to:

```text
VibeShop/src/main/webapp/WEB-INF/lib/
```

Example:

```text
mysql-connector-j-8.0.xx.jar
```

## Current implemented DAO classes

```text
UserDAO
ProductDAO
OrderDAO
```

`UserDAO` is already wired into `LoginServlet` and `RegisterServlet`.

## Registration fields

The registration form now sends:

```text
nome
cognome
email
cellulare
password
confirmPassword
```

`cellulare` is optional. All other fields are required.

## Password handling

Passwords are stored and checked through MySQL:

```sql
SHA2(?, 256)
```

This matches the current `utente.password_hash` column.
