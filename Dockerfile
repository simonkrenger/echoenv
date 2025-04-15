FROM registry.fedoraproject.org/fedora-minimal:42 as build
LABEL maintainer="Simon Krenger <simon@krenger.ch>"
LABEL description="A small container that returns the environment variables plus some basic information on port 8080"

WORKDIR /go/src/github.com/simonkrenger/echoenv
RUN microdnf install -y golang
COPY echoenv.go .
COPY go.mod .
RUN go get github.com/gin-gonic/gin
# http://blog.wrouesnel.com/articles/Totally%20static%20Go%20builds/
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' .

FROM scratch
LABEL maintainer="Simon Krenger <simon@krenger.ch>"
LABEL description="A small container that returns the environment variables plus some basic information on port 8080"
WORKDIR /
COPY --from=0 /go/src/github.com/simonkrenger/echoenv/echoenv .

ENV GIN_MODE release
ENV PORT 8080
EXPOSE $PORT
USER 1001
CMD ["./echoenv"]
