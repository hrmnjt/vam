# VAM!

Vertica Access Management

## References

**Starting Vertica**

Link - https://hub.docker.com/r/dataplatform/docker-vertica/

```bash
docker run -p 5433:5433 -d -v $PWD/vertica/vertica_data:/home/dbadmin/docker dataplatform/docker-vertica

# Default DB Name - docker
# Default User - dbadmin
# Default Password (NO PASSWORD)
```

**Starting directus (for legacy record)**

Link - https://docs.directus.io/guides/installation/docker.html#docker-compose

Create `docker-compose`

```bash
cat >> directus/docker-compose.yml <<EOL
version: '3.2'
services:
  database:
    container_name: database
    image: postgres:12
    volumes:
      - ./data/database:/var/lib/postgresql/data
    networks:
      - directus
    environment:
      POSTGRES_USER: 'directus'
      POSTGRES_PASSWORD: 'directus'
      POSTGRES_DB: 'directus'

  cache:
    container_name: cache
    image: redis:6
    networks:
      - directus

  directus:
    container_name: directus
    image: directus/directus:v9.0.0-rc.24
    ports:
      - 8055:8055
    networks:
      - directus
    depends_on:
      - cache
      - database
    environment:
      KEY: '255d861b-5ea1-5996-9aa3-922530ec40b1'
      SECRET: '6116487b-cda1-52c2-b5b5-c8022c45e263'

      DB_CLIENT: 'pg'
      DB_HOST: 'database'
      DB_PORT: '5432'
      DB_DATABASE: 'directus'
      DB_USER: 'directus'
      DB_PASSWORD: 'directus'

      CACHE_ENABLED: 'true'
      CACHE_STORE: 'redis'
      CACHE_REDIS: 'redis://cache:6379'

      ADMIN_EMAIL: 'admin@example.com'
      ADMIN_PASSWORD: 'd1r3ctu5'

networks:
  directus:
EOL
```

Run compose and visit http://localhost:8055
```
docker-compose -f directus/docker-compose.yml up -d
```