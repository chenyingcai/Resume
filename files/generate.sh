#!/bin/sh
OUTPUT_PATH="/usr/html/static"

apk update
apk add wget
mkdir -p $OUTPUT_PATH && cd $OUTPUT_PATH
wget http://127.0.0.1:80

cp -r /usr/html/user/themes/resume/css $OUTPUT_PATH/css
cp -r /usr/html/user/plugins/markdown-notices/assets/notices.css $OUTPUT_PATH/css

cp -r /usr/html/user/themes/resume/js $OUTPUT_PATH/js
cp -r /usr/html/system/assets/jquery/jquery-2.x.min.js $OUTPUT_PATH/js

cp -r /usr/html/user/themes/resume/icons $OUTPUT_PATH/icons
cp -r /usr/html/user/themes/resume/img $OUTPUT_PATH/img

sed -i 's|/user/themes/resume/||g' index.html
sed -i "s|/user/plugins/markdown-notices/assets/|css/|g" index.html
sed -i "s|/system/assets/jquery/|js/|g" index.html

echo "Done."
