#!/bin/bash
docker-compose run house-service bundle
docker-compose run house-service ./cli db_migrate
cd ../house-service/docs && mkdocs build # build api doc