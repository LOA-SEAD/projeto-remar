set -m

MONGO_CHECK=1
while [[ MONGO_CHECK -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    MONGO_CHECK=$?
done

echo "MongoDB successfully started."

MYSQL_CHECK=1
while [[ MYSQL_CHECK -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
	MYSQL_CHECK=$(mysql -e "SHOW VARIABLES LIKE '%version%';" || echo 0)
done

echo "MySQL successfully started."
echo "=========== STARTING REMAR. ================"

catalina.sh run