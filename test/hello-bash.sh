#!/bin/bash

# 创建 .dockerignore 文件
echo ".git" > .dockerignore
echo "node_modules" >> .dockerignore
echo "npm-debug.log" >> .dockerignore

# 创建 Dockerfile 文件
echo "FROM node:18.16.0" > Dockerfile
echo "COPY . /app" >> Dockerfile
echo "WORKDIR /app" >> Dockerfile
echo "RUN npm install --registry=https://registry.npm.taobao.org" >> Dockerfile
echo "EXPOSE 3000" >> Dockerfile

# 构建 image 文件
docker image build -t test . --file Dockerfile --tag $IMAGE_NAME

# 生成容器
docker container run --rm -p 8000:3000 -it test /bin/bash

# 完成
echo "success!"

#登录dockerhub
docker login --username=capxh73  --password=qq5213995 

#为本地的 image 标注用户名和版本。
docker image tag test capxh73/test

#发布 image 文件
docker push capxh73/test

# 执行下面的命令
#node test/hello-world.js

