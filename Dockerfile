FROM mysql
ENV MYSQL_DATABASE=<devopsdocker> \
    MYSQL_ROOT_PASSWORD=<root>
 
ADD schema.sql /docker-entrypoint-initdb.d

EXPOSE 3306