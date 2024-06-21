#!/bin/bash
APP_NAME="docker-backend"
VERSION="1.0.1"
PORT="10001"
APP_NAME_OLD="${APP_NAME}-old"

# 1. Change the current docker container name to old
echo "---------- [Deploy Step - 1] : Rename Current Docker Container"
docker rename ${APP_NAME} ${APP_NAME_OLD}
# 2. Change the current docker images name to old
echo "---------- [Deploy Step - 2] : Rename Current Docker Image"
docker tag ${APP_NAME}:${VERSION} ${APP_NAME_OLD}:${VERSION}
# 3. Build the application
echo "---------- [Deploy Step - 3] : Build the application"
./mvnw clean package
# 4. Build the docker image
echo "---------- [Deploy Step - 4] : Build New Docker Image"
docker build -t ${APP_NAME}:${VERSION} .
# 5. Stop the old docker container
echo "---------- [Deploy Step - 5] : Stop Old Docker Container"
docker stop ${APP_NAME_OLD}
# 6. Remove the old docker container
echo "---------- [Deploy Step - 6] : Remove Old Docker Container"
docker rm ${APP_NAME_OLD}
# 7. Remove the old docker image
echo "---------- [Deploy Step - 7] : Remove Old Docker Image"
docker rmi ${APP_NAME_OLD}:${VERSION}
# 8. Run new docker container
echo "---------- [Deploy Step - 8] : Run New Docker Container"
docker run -d -p ${PORT}:8080 \
  -v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Seoul \
  --restart unless-stopped \
  --name ${APP_NAME} \
  ${APP_NAME}:${VERSION}