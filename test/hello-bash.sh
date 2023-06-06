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
docker image build -t test .

# 生成容器
docker container run --rm -p 8000:3000 -it test /bin/bash

# 执行下面的命令
node test/hello-world.js
