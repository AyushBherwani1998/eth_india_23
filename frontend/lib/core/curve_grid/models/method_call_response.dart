class MethodCallResponse<T> {
    final int status;
    final String message;
    final MethodCallResult<T> result;

    MethodCallResponse({
        required this.status,
        required this.message,
        required this.result,
    });

    factory MethodCallResponse.fromJson(Map<String, dynamic> json) => MethodCallResponse(
        status: json["status"],
        message: json["message"],
        result: MethodCallResult.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result.toJson(),
    };
}

class MethodCallResult<T> {
    final String kind;
    final T output;

    MethodCallResult({
        required this.kind,
        required this.output,
    });

    factory MethodCallResult.fromJson(Map<String, dynamic> json) => MethodCallResult(
        kind: json["kind"],
        output: json["output"],
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "output": output,
    };
}