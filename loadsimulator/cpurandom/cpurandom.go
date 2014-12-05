package main

import (
  "fmt"
  "math/rand"
  "time"
)

func main() {
  rand.Seed(42)
  for {
    load := rand.Intn(10000)
    delay := rand.Intn(10)
    fmt.Println("Load: ", load)

    for loadIterator := 0; loadIterator < load; loadIterator++ {
      time.Sleep(1 * time.Millisecond)
    }

    time.Sleep(time.Duration(delay) * time.Second)
  }
}
