FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY conf/mdb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/init.sh /usr/local/bin/init-db.sh
RUN chmod +x /usr/local/bin/init-db.sh

RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

EXPOSE 3306

ENTRYPOINT ["init-db.sh"]
