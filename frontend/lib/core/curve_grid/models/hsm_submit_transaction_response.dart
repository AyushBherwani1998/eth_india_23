class HSMSubmitTransactionResponse {
  final int status;
  final String message;
  final HSMSubmitTransactionResult result;

  HSMSubmitTransactionResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory HSMSubmitTransactionResponse.fromJson(Map<String, dynamic> json) =>
      HSMSubmitTransactionResponse(
        status: json["status"],
        message: json["message"],
        result: HSMSubmitTransactionResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

class HSMSubmitTransactionResult {
  final Transaction tx;
  final bool submitted;

  HSMSubmitTransactionResult({
    required this.tx,
    required this.submitted,
  });

  factory HSMSubmitTransactionResult.fromJson(Map<String, dynamic> json) =>
      HSMSubmitTransactionResult(
        tx: Transaction.fromJson(json["tx"]),
        submitted: json["submitted"],
      );

  Map<String, dynamic> toJson() => {
        "tx": tx.toJson(),
        "submitted": submitted,
      };
}

class Transaction {
  final String hash;

  Transaction({
    required this.hash,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        hash: json["hash"],
      );

  Map<String, dynamic> toJson() => {
        "hash": hash,
      };
}