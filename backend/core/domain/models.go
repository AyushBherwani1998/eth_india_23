package domain

type BalanceRequest struct {
	Address string `json:"address"`
	Chain   string `json:"chain"`
}

type BalanceResponse struct {
	TokenAddress       string `json:"token_address"`
	TokenID            string `json:"token_id"`
	TokenName          string `json:"token_name"`
	TokenBondedAddress string `json:"token_bonded_address"`
	Description        string `json:"description"`
	CollectionName     string `json:"collection_name"`
	URL                string `json:"url"`
}

type AttributeRequest struct {
	Address string `json:"address"`
	Chain   string `json:"chain"`
	Id      string `json:"id"`
}

type AttributeResponse struct {
	TraitType string `json:"trait_type"`
	Value     string `json:"value"`
}

type NFTBalanceResponse struct {
	Data Data `json:"data"`
}
type ProjectDetails struct {
	Description    string `json:"description"`
	ImageURL       string `json:"imageUrl"`
	CollectionName string `json:"collectionName"`
}
type Token struct {
	Name           string         `json:"name"`
	ProjectDetails ProjectDetails `json:"projectDetails"`
}
type TokenNfts struct {
	Token    Token  `json:"token"`
	TokenURI string `json:"tokenURI"`
}
type TokenBalance struct {
	TokenAddress string    `json:"tokenAddress"`
	TokenID      string    `json:"tokenId"`
	TokenNfts    TokenNfts `json:"tokenNfts"`
}
type TokenBalances struct {
	TokenBalance []TokenBalance `json:"TokenBalance"`
}
type Data struct {
	TokenBalances TokenBalances `json:"TokenBalances"`
}

type SpecificBoundAccountResponse struct {
	Data struct {
		Accounts struct {
			Account []struct {
				Address struct {
					Addresses []string `json:"addresses"`
				} `json:"address"`
			} `json:"Account"`
		} `json:"Accounts"`
	} `json:"data"`
}

type TokenAttributeResponse struct {
	Data struct {
		Base struct {
			TokenBalance []struct {
				TokenNfts struct {
					MetaData struct {
						Attributes []struct {
							TraitType string `json:"trait_type"`
							Value     string `json:"value"`
						} `json:"attributes"`
					} `json:"metaData"`
				} `json:"tokenNfts"`
			} `json:"TokenBalance"`
		} `json:"Base"`
	} `json:"data"`
}
