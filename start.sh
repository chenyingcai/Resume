#!/bin/sh
RESUME_PATH="$PWD/resume"
RESUME_PORT="$1"
echo "Port: ${RESUME_PORT:="8080"}"

mkdir -p $RESUME_PATH
docker run -d --name resume_tmp chenyingcai/resume:v1
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
    --restart=always chenyingcai/resume:v1
echo "run the ngnix"
docker exec -it resume run
echo "Done"
echo "generate the initial html file"
docker exec -it resume generate
echo "Done"