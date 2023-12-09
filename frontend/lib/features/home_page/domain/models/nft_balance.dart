class NFTBalanceResponse {
  String tokenAddress;
  String tokenId;
  String tokenName;
  String tokenBoundedAddress;
  String description;
  String collectionName;
  String url;

  NFTBalanceResponse({
    required this.tokenAddress,
    required this.tokenId,
    required this.tokenName,
    required this.tokenBoundedAddress,
    required this.description,
    required this.collectionName,
    required this.url,
  });

  factory NFTBalanceResponse.fromJson(Map<String, dynamic> json) =>
      NFTBalanceResponse(
        tokenAddress: json["token_address"],
        tokenId: json["token_id"],
        tokenName: json["token_name"],
      tokenBoundedAddress: json["token_bonded_address"],
        description: json["description"],
        collectionName: json["collection_name"],
        url: json["url"]!,
      );

  Map<String, dynamic> toJson() => {
        "token_address": tokenAddress,
        "token_id": tokenId,
        "token_name": tokenName,
        "token_bonded_address": tokenBoundedAddress,
        "description": description,
        "collection_name": collectionName,
        "url": url,
      };
}
