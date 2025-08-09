FROM postgres:alpine

# Set up entrypoint
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

# Create a 'dev' database and user
USER postgres
RUN initdb -D /var/lib/postgresql/data && \
    pg_ctl -D /var/lib/postgresql/data start && \
    createdb dev && \
    createuser dev && \
    pg_ctl -D /var/lib/postgresql/data stop

# Start postgres and open psql
ENTRYPOINT ["/opt/entrypoint.sh"]
