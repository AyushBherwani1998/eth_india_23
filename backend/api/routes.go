package api

import (
	"ETHIndia2023/api/handlers"
	"ETHIndia2023/core/infrastructure/airstack"
	"github.com/gorilla/mux"
)

func NewRoutes(airStack *airstack.Airstack) *mux.Router {
	webHandler := handlers.NewHandler(airStack)
	r := mux.NewRouter()

	r.HandleFunc("/v1/{chain}/address/{address}/balance", webHandler.NFTBalanceHandler()).Methods("GET")
	r.HandleFunc("/v1/{chain}/address/{address}/id/{id}/attributes", webHandler.AttributesHandler()).Methods("GET")
	return r
}
