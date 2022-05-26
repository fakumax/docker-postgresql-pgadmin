*Run First Permission*

sudo chmod -R 777  /var/run/docker.sock


*Next*

docker-compose up -d

*Inside Postgres*
docker exec -it postgresql14  bash
su - postgres
psql

*Restore DB*
psql -U username -f backupfile.sql