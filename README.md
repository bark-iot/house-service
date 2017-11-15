# house-service

See `bark` repository for instructions.

# API docs
- to view go to [http://localhost/houses/docs](http://localhost/houses/docs)
- to build run `cd docs && mkdocs build`

# Migrations
- `docker-compose run house-service ./cli db_migrate`

# Run tests
- `dc run house-service rspec`