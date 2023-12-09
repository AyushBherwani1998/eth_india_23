class TokenBalanceResponse {
    Data data;

    TokenBalanceResponse({
        required this.data,
    });

    factory TokenBalanceResponse.fromJson(Map<String, dynamic> json) => TokenBalanceResponse(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    TokenBalances tokenBalances;

    Data({
        required this.tokenBalances,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        tokenBalances: TokenBalances.fromJson(json["TokenBalances"]),
    );

    Map<String, dynamic> toJson() => {
        "TokenBalances": tokenBalances.toJson(),
    };
}

class TokenBalances {
    List<TokenBalance> tokenBalance;

    TokenBalances({
        required this.tokenBalance,
    });

    factory TokenBalances.fromJson(Map<String, dynamic> json) => TokenBalances(
        tokenBalance: List<TokenBalance>.from(json["TokenBalance"].map((x) => TokenBalance.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "TokenBalance": List<dynamic>.from(tokenBalance.map((x) => x.toJson())),
    };
}

class TokenBalance {
    String tokenAddress;
    String tokenId;
    TokenNfts tokenNfts;

    TokenBalance({
        required this.tokenAddress,
        required this.tokenId,
        required this.tokenNfts,
    });

    factory TokenBalance.fromJson(Map<String, dynamic> json) => TokenBalance(
        tokenAddress: json["tokenAddress"],
        tokenId: json["tokenId"],
        tokenNfts: TokenNfts.fromJson(json["tokenNfts"]),
    );

    Map<String, dynamic> toJson() => {
        "tokenAddress": tokenAddress,
        "tokenId": tokenId,
        "tokenNfts": tokenNfts.toJson(),
    };
}

class TokenNfts {
    Token token;

    TokenNfts({
        required this.token,
    });

    factory TokenNfts.fromJson(Map<String, dynamic> json) => TokenNfts(
        token: Token.fromJson(json["token"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token.toJson(),
    };
}

class Token {
    String name;
    ProjectDetails projectDetails;

    Token({
        required this.name,
        required this.projectDetails,
    });

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        name: json["name"],
        projectDetails: ProjectDetails.fromJson(json["projectDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "projectDetails": projectDetails.toJson(),
    };
}

class ProjectDetails {
    String description;
    String imageUrl;

    ProjectDetails({
        required this.description,
        required this.imageUrl,
    });

    factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
        description: json["description"],
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "imageUrl": imageUrl,
    };
}
