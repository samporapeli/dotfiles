#!/bin/sh

pg_ctl -D /var/lib/postgresql/data start && psql dev
