#!/bin/sh
set -e

echo "Starting MariaDB initialization..."

# DB_ROOT_PASSWORD=$(cat "$MYSQL_ROOT_PASSWORD_FILE")
# DB_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")
DB_ROOT_PASSWORD=pass
DB_PASSWORD=upass

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

mysqld --user=mysql --bootstrap << EOF_SQL
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF_SQL

echo "MariaDB initialization complete!"
echo "Starting MariaDB server..."

exec mysqld --user=mysql --console
