#!/bin/bash
docker-compose  up -d  --build


if [[ ${?} = 0 ]]
then
  echo "Containers are running now"
  echo "Importing database"
fi
  while true [[ $(docker exec  demo-db  mysqladmin ping  -u root -pTest@1234 |grep "alive"  ) ==  *alive* ]]; do

echo "Removng Existing database"
docker exec demo-app  php artisan  db:wipe
echo "Waiting For Database to UP"
docker exec demo-app  php artisan  migrate --seed > /dev/null 2>&1
if [[ ${?} = 0 ]]
then
 echo "Database Imported Sucessfully"
exit 0
else
 echo "Database Not Imported"
fi
done
