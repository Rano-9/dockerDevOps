FROM ubuntu
RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash
RUN apt-get install -y nodejs
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
EXPOSE 5001
RUN npm install
RUN npm run build
RUN npm install -g serve
CMD ["serve", "-s", "-l", "5001", "build"]
