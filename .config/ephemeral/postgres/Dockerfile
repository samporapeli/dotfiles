FROM postgres:alpine

# Create a 'dev' database and user
USER postgres
RUN initdb -D /var/lib/postgresql/data && \
    pg_ctl -D /var/lib/postgresql/data start && \
    createdb dev && \
    createuser dev && \
    pg_ctl -D /var/lib/postgresql/data stop

# Start postgres and open psql
CMD pg_ctl -D /var/lib/postgresql/data start && psql dev
