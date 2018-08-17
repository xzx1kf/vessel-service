# vessel-service/Dockerfile
FROM golang:1.10.3 as builder

WORKDIR /go/src/github.com/xzx1kf/vessel-service

COPY . .

RUN go get -u github.com/golang/dep/cmd/dep
RUN dep init && dep ensure
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm go build -a -installsuffix cgo .


FROM arm32v7/debian:latest

RUN mkdir /app
WORKDIR /app
COPY --from=builder /go/src/github.com/xzx1kf/vessel-service/vessel-service .

CMD ["./vessel-service"]
