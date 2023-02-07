#!/bin/bash

docker-compose  up -d  --build


if [[ ${?} = 0 ]]
then
  echo "Containers are running now"
  echo "Importing database"
docker exec demo-app  php artisan  migrate --seed

fi

