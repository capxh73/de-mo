#!/bin/bash

# 创建 .dockerignore 文件
echo ".git" > test/.dockerignore
echo "node_modules" >> test/.dockerignore
echo "npm-debug.log" >> test/.dockerignore

# 创建 Dockerfile 文件
echo "FROM node:8.4" > test/dockerfile
echo "COPY . /app" >> test/dockerfile
echo "WORKDIR /app" >> test/dockerfile
echo "RUN npm install --registry=https://registry.npm.taobao.org" >> test/dockerfile
echo "EXPOSE 3000" >> test/dockerfile

# 构建 image 文件
docker image build -t test .

# 生成容器
docker container run --rm -p 8000:3000 -it test /bin/bash

# 执行下面的命令
node test/hello-world.js