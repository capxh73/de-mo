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

# 镜像名
IMAGE_NAME=test

# 构建 image 文件
docker image build -t &IMAGE_NAME . 

# 生成容器
docker container run --rm -p 8000:3000 -it &IMAGE_NAME /bin/bash

# 完成
echo "success!"

#登录dockerhub
docker login --username=$DOCKERHUB_USERNAME  --password=$DOCKERHUB_PASSWORD

#为本地的 image 标注用户名和版本。
docker image tag &IMAGE_NAME capxh73/&IMAGE_NAME

#发布 image 文件
docker push capxh73/&IMAGE_NAME

# 执行下面的命令
#node test/hello-world.js

