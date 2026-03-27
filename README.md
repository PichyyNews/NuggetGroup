# NuggetGroup Network Stack

This branch standardizes the project into a single `docker compose up -d` workflow with one public entry point on port `80`.

## Architecture

The stack now has four services:

- `s2proxy`: Nginx reverse proxy published on host port `80`
- `s2app`: Strapi application, available internally on port `1337`
- `s2admin`: pgAdmin, available internally on port `80`
- `s2db`: PostgreSQL, available only on the internal backend network

Traffic is routed through Nginx like this:

- `http://localhost/` -> Strapi
- `http://localhost/admin` -> Strapi Admin
- `http://localhost/pgadmin/` -> pgAdmin

## Security Baseline

The compose stack is prepared to be merged into `develop` with the following defaults:

- only one host port is published: `80`
- PostgreSQL is not exposed to the host
- the database lives on an internal Docker network
- runtime secrets are loaded from `.env`
- pgAdmin runs with persistent storage and a preloaded server definition generated from `.env`
- Nginx adds basic hardening headers and acts as the only public entry point

Before deploying to any shared environment, replace all default passwords in `.env`.

## Quick Start

1. Create the environment file:

   ```bash
   cp .env.example .env
   ```

2. Update the credentials in `.env`.

3. Start the full stack:

   ```bash
   docker compose up -d
   ```

4. Check container status:

   ```bash
   docker compose ps
   ```

## Access

- Strapi: [http://localhost/](http://localhost/)
- Strapi Admin: [http://localhost/admin](http://localhost/admin)
- pgAdmin: [http://localhost/pgadmin/](http://localhost/pgadmin/)

Use the pgAdmin credentials from `.env` to log in. The PostgreSQL server named `Nugget PostgreSQL` is generated automatically from the current `.env` values on startup. Enter the database password from `.env` when pgAdmin asks for the server password.

## Notes For Review

- `docker-compose.yaml` is now the single source of truth for the stack
- the previous split files (`admin.yaml`, `app.yaml`, `db.yaml`) were removed to avoid drift
- the database health check now validates against the actual PostgreSQL environment variables used inside the container
- if you are migrating from an older local stack with an existing PostgreSQL volume and changed `DB_PASSWORD`, reinitialize once with `docker compose down -v`
