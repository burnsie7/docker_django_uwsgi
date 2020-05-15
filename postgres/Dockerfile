FROM postgres:9.4
EXPOSE 5432
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
COPY create_operations.sh /docker-entrypoint-initdb.d/create_operations.sh
