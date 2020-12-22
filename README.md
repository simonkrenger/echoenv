# echoenv

A small container that returns the environment variables plus some basic request information on port 8080.

Example:

```
$ podman run -d -p 8080:8080 quay.io/simonkrenger/echoenv
$ curl localhost:8080/abc | jq
{
  "env": [
    "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    "TERM=xterm",
    "HOSTNAME=95b22f86671a",
    "container=podman",
    "HOME=/root"
  ],
  "hostname": "95b22f86671a",
  "process": {
    "gid": 0,
    "pid": 1,
    "uid": 0
  },
  "request": {
    "header": {
      "Accept": [
        "*/*"
      ],
      "User-Agent": [
        "curl/7.66.0"
      ]
    },
    "host": "localhost:8080",
    "method": "GET",
    "protocol": "HTTP/1.1",
    "requestURI": "/abc",
    "url": {
      "Scheme": "",
      "Opaque": "",
      "User": null,
      "Host": "",
      "Path": "/abc",
      "RawPath": "",
      "ForceQuery": false,
      "RawQuery": "",
      "Fragment": ""
    }
  }
}
```

Or as a `Pod`:

```
apiVersion: v1
kind: Pod
metadata:
  name: echoenv-pod
  labels:
    app: echoenv
spec:
  containers:
  - name: echoenv
    image: quay.io/simonkrenger/echoenv:latest
    ports:
    - containerPort: 8080
```
