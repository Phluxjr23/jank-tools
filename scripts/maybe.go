package main

import (
	"fmt"
	"math/rand"
	"os"
	"os/exec"
	"strings"
	"time"
)

func main() {
	rand.Seed(time.Now().UnixNano())
	
	if len(os.Args) < 2 {
		fmt.Println("usage: maybe <command>")
		fmt.Println("50/50 chance of running the command")
		return
	}
	
	command := strings.Join(os.Args[1:], " ")
	
	if rand.Float64() < 0.5 {
		fmt.Printf("maybe... yes! running: %s\n", command)
		
		cmd := exec.Command("sh", "-c", command)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		cmd.Stdin = os.Stdin
		
		if err := cmd.Run(); err != nil {
			fmt.Fprintf(os.Stderr, "error: %v\n", err)
			os.Exit(1)
		}
	} else {
		fmt.Printf("maybe... no. not running: %s\n", command)
	}
}
