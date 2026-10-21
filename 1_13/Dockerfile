FROM golang:1.16
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
EXPOSE 8080
ENV PORT=8080
ENV REQUEST_ORIGIN=*
RUN go build
CMD ["./server"]
