-- Run as the MySQL root/admin user:
--   mysql -u root -p < sql/01_create_db.sql
-- MySQL has no "database owner", so the user is given full privileges on the database.

CREATE DATABASE IF NOT EXISTS ipl_db;

CREATE USER IF NOT EXISTS 'ipl_user'@'localhost' IDENTIFIED BY 'ipl_password';

GRANT ALL PRIVILEGES ON ipl_db.* TO 'ipl_user'@'localhost';
FLUSH PRIVILEGES;
