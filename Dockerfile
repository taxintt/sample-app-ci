# step1: build
# FROM golang:1.13-alpine AS build -> docker image ls --digests
FROM golang:1.10.1-alpine3.7 AS build

ENV CGO_ENABLED=0
ENV CGO_GOOS=Linux
ENV CGO_GOARCH=amd64

# ENV GOPATH=/go
# WORKDIR /go/src/
# COPY /src/ /go/src
WORKDIR /src/
COPY /src/main/main.go /src/
COPY go.* /src/

RUN go build -o /bin/demo

# step2: exec
FROM scratch
COPY --from=build /bin/demo /bin/demo
ENTRYPOINT ["/bin/demo"]