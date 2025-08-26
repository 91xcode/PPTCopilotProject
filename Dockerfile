FROM node:16

WORKDIR /home/app

COPY . . 

RUN npm config set registry https://registry.npmmirror.com/ && npm install --legacy-peer-deps
# 构建生产版本以减少内存占用
RUN npm run build:prod

EXPOSE 9529

# 如果arg server_ip不为空，则替换配置文件中的server_ip
ARG SERVER_IP
# 运行env.py传递参数
RUN python3 env.py $SERVER_IP

# 安装serve来运行静态文件
RUN npm install -g serve
CMD ["serve", "-s", "dist", "-l", "9529"]
