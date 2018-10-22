FROM golang:latest
WORKDIR /go/src/gitlab.com/simonkrenger/echoenv
RUN go get github.com/gin-gonic/gin
COPY echoenv.go .
ENV GIN_MODE release
RUN go build .

FROM debian:8-slim
RUN apt-get update && apt-get -y upgrade && apt-get -q -y clean
WORKDIR /
COPY --from=0 /go/src/gitlab.com/simonkrenger/echoenv/echoenv .

EXPOSE 8080
CMD ["./echoenv"]
