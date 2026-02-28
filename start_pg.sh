podman run -d --name pg1 -e POSTGRES_PASSWORD=pglol -p 5433:5432 -v /home/vmihailov/pg_data:/var/lib/postgresql/data postgres:latest
