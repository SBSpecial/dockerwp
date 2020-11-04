USE mysql;
ALTER user 'root'@'localhost' IDENTIFIED BY 'W3lcome!1';

CREATE DATABASE wpdp;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'W3lcome!1';
GRANT ALL PRIVILEGES ON wpdb.* TO 'wpuser'@'localhost';
