package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	distro := "arch"
	
	// try to detect distro
	if data, err := os.ReadFile("/etc/os-release"); err == nil {
		content := string(data)
		lines := strings.Split(content, "\n")
		for _, line := range lines {
			if strings.HasPrefix(line, "ID=") {
				distro = strings.Trim(strings.TrimPrefix(line, "ID="), "\"")
				break
			}
		}
	}
	
	fmt.Printf("i use %s btw\n", distro)
}
