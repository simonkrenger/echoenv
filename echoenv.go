package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

// https://github.com/gin-gonic/gin

func main() {
	router := gin.Default()

	// Normal case
	router.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, getEnvironment(c))
	})

	// Handle any route
	router.NoRoute(func(c *gin.Context) {
		c.JSON(http.StatusFound, getEnvironment(c))
	})

	// By default it serves on :8080 unless a
	// PORT environment variable was defined.
	router.Run()
}

func getEnvironment(c *gin.Context) gin.H {

	hostname, err := os.Hostname()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Unable to get hostname: %s", err.Error())
	}

	return gin.H{
		"hostname": hostname,
		"env":      os.Environ(),
		"process": gin.H{
			"pid": os.Getpid(),
			"uid": os.Getuid(),
			"gid": os.Getgid(),
		},
		"request": gin.H{
			"method":     c.Request.Method,
			"requestURI": c.Request.RequestURI,
			"protocol":   c.Request.Proto,
			"header":     c.Request.Header,
			"host":       c.Request.Host,
			"url":        c.Request.URL,
		},
	}
}
