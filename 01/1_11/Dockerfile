FROM amazoncorretto:8
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN ./mvnw package
EXPOSE 8080
CMD ["java","-jar","./target/docker-example-1.1.3.jar"]
