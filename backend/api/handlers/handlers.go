package handlers

import (
	"ETHIndia2023/core/domain"
	"ETHIndia2023/core/infrastructure/airstack"
	"encoding/json"
	"fmt"
	"github.com/gorilla/mux"
	"log"
	"net/http"
)

type Handler struct {
	airstack *airstack.Airstack
}

func NewHandler(airstack *airstack.Airstack) *Handler {
	return &Handler{
		airstack: airstack,
	}
}

func (h *Handler) NFTBalanceHandler() http.HandlerFunc {
	var result []domain.BalanceResponse
	var err error
	return func(w http.ResponseWriter, r *http.Request) {
		vars := mux.Vars(r)
		chain := vars["chain"]
		address := vars["address"]
		request := domain.BalanceRequest{
			Address: address,
			Chain:   chain,
		}
		log.Println("Requesting balance...")
		result, err = h.airstack.GetNFTBalance(request)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error fetching NFT's %v", err.Error()), http.StatusInternalServerError)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(result)
	}
}

func (h *Handler) AttributesHandler() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		vars := mux.Vars(r)
		chain := vars["chain"]
		address := vars["address"]
		id := vars["id"]
		request := domain.AttributeRequest{
			Address: address,
			Chain:   chain,
			Id:      id,
		}
		log.Println("Requesting attributes...")
		result, err := h.airstack.GetAttributes(request)
		if err != nil {
			http.Error(w, fmt.Sprintf("Error fetching attributes %v", err.Error()), http.StatusInternalServerError)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(result)
	}
}
