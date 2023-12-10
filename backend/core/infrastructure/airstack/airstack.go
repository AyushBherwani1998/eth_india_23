package airstack

import (
	"ETHIndia2023/core/domain"
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"
	"strings"
	"sync"
)

type Airstack struct {
}

func AirstackService() *Airstack {
	return &Airstack{}
}

func (a *Airstack) GetNFTBalance(request domain.BalanceRequest) ([]domain.BalanceResponse, error) {
	var response []domain.BalanceResponse

	url := "https://api.airstack.xyz/gql"
	method := "POST"

	payload := strings.NewReader("{\"query\":\"query MyQuery {\\n  TokenBalances(\\n    input: {filter: {owner: {_in: [\\\"" + request.Address + "\\\"]}, tokenType: {_in: [ERC721]}}, blockchain: " + request.Chain + ", limit: 10}\\n  ) {\\n    TokenBalance {\\n      tokenAddress\\n      tokenId\\n      tokenNfts {\\n        token {\\n          name\\n          projectDetails {\\n            description\\n            imageUrl\\n            collectionName\\n          }\\n        }\\n        tokenURI\\n        metaData {\\n          attributes {\\n            trait_type\\n            value\\n          }\\n        }\\n      }\\n    }\\n  }\\n}\",\"variables\":{}}")
	client := &http.Client{}
	log.Println("Initializing client...")
	req, err := http.NewRequest(method, url, payload)
	if err != nil {
		log.Println(err)
		return []domain.BalanceResponse{}, err
	}
	req.Header.Add("Content-Type", "application/json")

	log.Println("Fetching response")
	res, err := client.Do(req)
	if err != nil {
		log.Println(err)
		return []domain.BalanceResponse{}, err
	}
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		log.Println(err)
		return []domain.BalanceResponse{}, err
	}

	var nftResponse domain.NFTBalanceResponse
	log.Println("Unmarshalling response")
	err = json.Unmarshal(body, &nftResponse)
	if err != nil {
		log.Println("Error unmarshalling data", err.Error())
		return []domain.BalanceResponse{}, err
	}

	var wg sync.WaitGroup
	var mu sync.Mutex

	for _, nftResp := range nftResponse.Data.TokenBalances.TokenBalance {
		wg.Add(1)
		go func(nftResp domain.TokenBalance) {
			defer wg.Done()
			var result domain.BalanceResponse
			result.TokenAddress = nftResp.TokenAddress
			result.TokenName = nftResp.TokenNfts.Token.Name
			result.TokenID = nftResp.TokenID
			bondedAddress := bondedToken(nftResp.TokenAddress)
			result.TokenBondedAddress = bondedAddress
			result.Description = nftResp.TokenNfts.Token.ProjectDetails.Description
			result.CollectionName = nftResp.TokenNfts.Token.ProjectDetails.CollectionName
			result.URL = nftResp.TokenNfts.TokenURI
			mu.Lock()
			response = append(response, result)
			mu.Unlock()
		}(nftResp)
	}

	wg.Wait()
	if len(response) == 0 {
		response = []domain.BalanceResponse{}
	}
	return response, nil
}

func (a *Airstack) GetAttributes(request domain.AttributeRequest) ([]domain.AttributeResponse, error) {
	var response []domain.AttributeResponse
	url := "https://api.airstack.xyz/gql"
	method := "POST"
	payload := strings.NewReader("{\"query\":\"query MyQuery {\\n  Base: TokenBalances(\\n    input: {filter: {tokenType: {_in: [ERC721]}, tokenId: {_eq: \\\"" + request.Id + "\\\"}, tokenAddress: {_eq: \\\"" + request.Address + "\\\"}}, blockchain: " + request.Chain + ", limit: 10}\\n  ) {\\n    TokenBalance {\\n      tokenNfts {\\n        metaData {\\n          attributes {\\n            trait_type\\n            value\\n          }\\n        }\\n      }\\n    }\\n  }\\n}\",\"variables\":{}}")
	client := &http.Client{}
	req, err := http.NewRequest(method, url, payload)

	if err != nil {
		log.Println(err)
		return []domain.AttributeResponse{}, nil
	}
	req.Header.Add("Content-Type", "application/json")

	res, err := client.Do(req)
	if err != nil {
		log.Println(err)
		return []domain.AttributeResponse{}, nil
	}
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		log.Println(err)
		return []domain.AttributeResponse{}, nil
	}
	var attributeResponse domain.TokenAttributeResponse
	err = json.Unmarshal(body, &attributeResponse)
	if err != nil {
		log.Println("Error unmarshalling data", err.Error())
		return []domain.AttributeResponse{}, nil
	}

	if len(attributeResponse.Data.Base.TokenBalance) > 0 {
		for _, attribute := range attributeResponse.Data.Base.TokenBalance[0].TokenNfts.MetaData.Attributes {
			var result domain.AttributeResponse
			result.TraitType = attribute.TraitType
			result.Value = attribute.Value
			response = append(response, result)
		}
	}
	if len(response) == 0 {
		response = []domain.AttributeResponse{}
	}
	return response, nil
}

func bondedToken(address string) string {
	var boundedTokenAddress string
	url := "https://api.airstack.xyz/gql"
	method := "POST"
	payload := strings.NewReader("{\"query\":\"query MyQuery {\\n  Accounts(\\n    input: {filter: {tokenAddress: {_eq: \\\"" + address + "\\\"}, tokenId: {_eq: \\\"1\\\"}}, blockchain: ethereum, limit: 100}\\n  ) {\\n    Account {\\n      address {\\n        addresses\\n      }\\n    }\\n  }\\n}\",\"variables\":{}}")
	client := &http.Client{}
	req, err := http.NewRequest(method, url, payload)

	if err != nil {
		log.Println(err)
		return ""
	}
	req.Header.Add("Content-Type", "application/json")

	res, err := client.Do(req)
	if err != nil {
		log.Println(err)
		return ""
	}
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		log.Println(err)
		return ""
	}
	var boundedTokenResponse domain.SpecificBoundAccountResponse
	err = json.Unmarshal(body, &boundedTokenResponse)
	if err != nil {
		log.Println("Error unmarshalling data", err.Error())
		return ""
	}

	for _, account := range boundedTokenResponse.Data.Accounts.Account {
		boundedTokenAddress = account.Address.Addresses[0]
	}
	return boundedTokenAddress
}
