package main

import (
  "fmt"
  "time"
)

func main() {
  for {
    load := 10000
    sleep := 5
    fmt.Println("Next cycle")

    for loadIterator := 0; loadIterator < load; loadIterator++ {
      time.Sleep(1 * time.Millisecond)
    }

    time.Sleep(time.Duration(sleep) * time.Second)
  }
}
