class TransctionToSignResponse {
  final int status;
  final String message;
  final TransactionToSignResult result;

  TransctionToSignResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory TransctionToSignResponse.fromJson(Map<String, dynamic> json) =>
      TransctionToSignResponse(
        status: json["status"],
        message: json["message"],
        result: TransactionToSignResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
      };
}

class TransactionToSignResult {
  final String kind;
  final Transction tx;
  final bool submitted;

  TransactionToSignResult({
    required this.kind,
    required this.tx,
    required this.submitted,
  });

  factory TransactionToSignResult.fromJson(Map<String, dynamic> json) {
    return TransactionToSignResult(
      kind: json["kind"],
      tx: Transction.fromJson(json["tx"]),
      submitted: json["submitted"],
    );
  }

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "tx": tx.toJson(),
        "submitted": submitted,
      };
}

class Transction {
  final String from;
  final String to;
  final String value;
  final int gas;
  final String gasFeeCap;
  final String gasTipCap;
  final String data;
  final int nonce;
  final String hash;
  final int type;

  Transction({
    required this.from,
    required this.to,
    required this.value,
    required this.gas,
    required this.gasFeeCap,
    required this.gasTipCap,
    required this.data,
    required this.nonce,
    required this.hash,
    required this.type,
  });

  factory Transction.fromJson(Map<String, dynamic> json) => Transction(
        from: json["from"],
        to: json["to"],
        value: json["value"],
        gas: json["gas"],
        gasFeeCap: json["gasFeeCap"],
        gasTipCap: json["gasTipCap"],
        data: json["data"],
        nonce: json["nonce"],
        hash: json["hash"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "value": value,
        "gas": gas,
        "gasFeeCap": gasFeeCap,
        "gasTipCap": gasTipCap,
        "data": data,
        "nonce": nonce,
        "hash": hash,
        "type": type,
      };
}