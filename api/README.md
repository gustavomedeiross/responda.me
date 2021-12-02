# api.responda.me

## Running the project locally:

### With elixir installed on your machine:

Create a postgres container, if you don't already have one:

```sh
docker run --name postgres -e POSTGRES_PASSWORD=secret -p 5432:5432 -d postgres
```

or 

```sh
docker-compose up -d postgres
```

Run the project
```sh
mix deps.get
mix phx.server
```

### Docker & Docker-compose:

Run the command `docker-compose up -d` in the root folder. This should build and run all the containers (phoenix & postgres) and setup all the required things.

After the services are up, run `docker-compose run api mix ecto.create` and `docker-compose run api mix ecto.migrate` to create and migrate the database.

