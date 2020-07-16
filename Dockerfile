FROM golang:1.14
LABEL maintainer="Simon Krenger <simon@krenger.ch>"
LABEL description="A small container that returns the environment variables plus some basic information on port 8080"

WORKDIR /go/src/gitlab.com/simonkrenger/echoenv
RUN go get github.com/gin-gonic/gin
COPY echoenv.go .
ENV GIN_MODE release
# http://blog.wrouesnel.com/articles/Totally%20static%20Go%20builds/
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' .

FROM scratch
WORKDIR /
COPY --from=0 /go/src/gitlab.com/simonkrenger/echoenv/echoenv .

EXPOSE 8080
USER 1001
CMD ["./echoenv"]
