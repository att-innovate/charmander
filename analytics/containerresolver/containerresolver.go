// The MIT License (MIT)
//
// Copyright (c) 2014 AT&T
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

package main

import (
    "fmt"
    "net/http"
	"html"
	"os/exec"
	"strings"
)

// Given a containerId we will resolve the taskId by searching for a folder named equal to the containerId
//
// Example directory/file structure for containerId: 0e0395b2-5b8f-48bb-bbbb-61442e7ad95c
// /tmp/mesos/slaves/20141212-182003-184623020-5050-1311-S6/frameworks/20141212-182003-184623020-5050-1311-0003/executors/cadvisor-1418409890561084623/runs/0e0395b2-5b8f-48bb-bbbb-61442e7ad95c
// TaskId would be: cadvisor-1418409890561084623
//
// Example request: http 172.31.2.12:31300/mesos-391b2b52-454c-49d4-aa9a-3a01f5d6e293
//

func handler(writer http.ResponseWriter, request *http.Request) {
	containerId := html.EscapeString(request.URL.Path)

    if strings.Contains(containerId, "getid"){

        writer.Header().Set("Access-Control-Allow-Origin", "*")

        id := html.EscapeString(request.URL.Path)
        id = id[1:] //remove leading /
        var zz = strings.Split(id, "/")
        fmt.Println("zz:",zz[1])
        cmd := exec.Command("docker","inspect", zz[1])
        output, _ := cmd.CombinedOutput()

        if len(output) == 0 { return }

        line := string(output)

        var newline = strings.Split(line, "/tmp/mesos/slaves/")
        var newline2 = strings.Split(newline[1],"/")

        fmt.Fprintf(writer, "%s\n", newline2[4])

    } else {

        containerId = containerId[1:] //remove leading /
        if strings.HasPrefix(containerId, "mesos-") {
            containerId = containerId[len("mesos-"):]
        }

        cmd := exec.Command("find", "/containers/", "-type", "d", "-name", containerId)
        output, _ := cmd.CombinedOutput()
        if len(output) == 0 { return }

        line = line[strings.Index(line, "executors/")+len("executors/"):]
        line = line[:strings.Index(line, "/")]

        fmt.Fprintf(writer, "%s\n", line)

    }

}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080", nil)
}
