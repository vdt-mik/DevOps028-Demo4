FROM postgres:9.6

ARG DB_NAME
ARG DB_USER
ARG DB_PASS

ENV POSTGRES_DB ${DB_NAME}
ENV POSTGRES_USER ${DB_USER}
ENV POSTGRES_PASSWORD ${DB_PASS}

EXPOSE 5432
USER postgres
VOLUME  ["/var/lib/postgresql"]