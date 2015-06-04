package main

import (
    "fmt"
    "net/http"
    "os/exec"
    "strings"
    "html"
)

func handler(writer http.ResponseWriter, request *http.Request) {
    writer.Header().Set("Access-Control-Allow-Origin", "*")

    id := html.EscapeString(request.URL.Path)
    id = id[1:] //remove leading /
    var zz = strings.Split(id, "/")

    cmd := exec.Command("docker","inspect", zz[1])
    output, _ := cmd.CombinedOutput()

    if len(output) == 0 { return }

    line := string(output)

    var newline = strings.Split(line, "/tmp/mesos/slaves/")
    var newline2 = strings.Split(newline[1],"/")

    fmt.Fprintf(writer, "%s\n", newline2[4])
}

func main() {
    http.HandleFunc("/getid/", handler)
    http.ListenAndServe(":9000", nil)
}
