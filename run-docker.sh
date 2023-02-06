#!/bin/bash

docker-compose  up -d


if [[ ${?} = 0 ]]
then
  echo " Containers are running now"
fi

docker exec  demo-app  php artisan migrate   --seed
