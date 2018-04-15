#!/bin/sh
DOCKER_NAME="chenyingcai/resume:v1"
RESUME_PATH="$PWD/resume"
RESUME_PORT="$1"
echo "Port: ${RESUME_PORT:="8080"}"
if [ "$(docker images -q $DOCKER_NAME 2> /dev/null)" == "" ]; then
  BUILD_PATH=$PWD
  echo "没有找到$DOCKER_NAME容器"
  echo "----------------------------------------------"
  echo "获取相关文档"
  wget https://github.com/chenyingcai/Resume/archive/master.zip
  unzip -o master.zip
  cd Resume-master
  rm -rf start.sh LICENSE README.md
  echo "----------------------------------------------"
  echo "开始创建c$DOCKER_NAME容器"
  docker build -t $DOCKER_NAME .
  cd $BUILD_PATH
  rm -rf master.zip Resume-master
  echo "done"
  echo "----------------------------------------------"
fi
mkdir -p $RESUME_PATH
docker run -d --name resume_tmp $DOCKER_NAME
if [ ! -d "$RESUME_PATH/config" ]; then
  docker cp resume_tmp:/usr/html/user/config $RESUME_PATH/config
fi
if [ ! -d "$RESUME_PATH/pages" ]; then
  docker cp resume_tmp:/usr/html/user/pages $RESUME_PATH/pages
fi
if [ ! -d "$RESUME_PATH/themes" ]; then
  docker cp resume_tmp:/usr/html/user/themes $RESUME_PATH/themes
fi
docker rm -f resume_tmp resume >/dev/null 2>&1
docker run -d --name resume -p $RESUME_PORT:80 \
    -v $RESUME_PATH/themes:/usr/html/user/themes \
    -v $RESUME_PATH/pages:/usr/html/user/pages \
    -v $RESUME_PATH/config/:/usr/html/user/config/ \
    -v $RESUME_PATH/static/:/usr/html/static \
    --restart=always $DOCKER_NAME
echo "run the ngnix"
docker exec -it resume run
echo "Done"
echo "generate the initial html file"
docker exec -it resume generate
echo "Done"
echo "open the preview web"
firefox -private "localhost:${RESUME_PORT:="8080"}"
