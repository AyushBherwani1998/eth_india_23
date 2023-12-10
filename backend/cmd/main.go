package main

import (
	"ETHIndia2023/api"
	"ETHIndia2023/core/infrastructure/airstack"
	"fmt"
	"log"
	"net/http"
)

func main() {
	airStack := airstack.AirstackService()
	router := api.NewRoutes(airStack)

	port := 8080
	serverAddress := fmt.Sprintf(":%d", port)
	log.Printf("Starting server on %s", serverAddress)
	err := http.ListenAndServe(serverAddress, router)
	if err != nil {
		log.Fatalf("Server error: %v", err)
	}
}
