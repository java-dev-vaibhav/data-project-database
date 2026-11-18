-- Run as the MySQL root/admin user:
--   mysql -u root -p < sql/02_cleanup.sql
-- Removes everything created by 01_create_db.sql.

DROP DATABASE IF EXISTS ipl_db;
DROP USER IF EXISTS 'ipl_user'@'localhost';
FLUSH PRIVILEGES;
