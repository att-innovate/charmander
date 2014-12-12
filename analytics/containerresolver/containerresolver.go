package main

import (
    "fmt"
    "net/http"
	"html"
	"os/exec"
	"os"
)

func handler(writer http.ResponseWriter, request *http.Request) {
	containerId := html.EscapeString(request.URL.Path)
    cmd := exec.Command("find", "/tmp/test", "-type", "d", "-name", containerId[1:])
    output, err := cmd.CombinedOutput()
    printError(err)
    if len(output) > 0 {
        fmt.Fprintf(writer, "%s\n", string(output))
    }

}

func printError(err error) {
  if err != nil {
    os.Stderr.WriteString(fmt.Sprintf("==> Error: %s\n", err.Error()))
  }
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080", nil)
}
