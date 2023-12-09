import 'package:frontend/core/curve_grid/curve_grid_network_client.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart' as web3;

import 'models/index.dart';

class CurveGridProvider {
  final CurveGridNetworkClient networkClient;

  CurveGridProvider(this.networkClient);

  Future<MethodCallResponse> callContractReadFunction<T>({
    required String contractLabel,
    required String contractType,
    required String methodName,
    required List<dynamic> args,
  }) async {
    final kCallContractFunctionPath =
        "chains/ethereum/addresses/$contractLabel/contracts/$contractType/methods/$methodName";

    final body = {
      "args": args,
    };

    try {
      final response = await networkClient.postAsync<Map<String, dynamic>>(
        kCallContractFunctionPath,
        body,
      );
      return MethodCallResponse<T>.fromJson(response);
    } catch (e, _) {
      rethrow;
    }
  }

  Future<TransctionToSignResponse> callContractWriteFunction({
    required String contractLabel,
    required String contractType,
    required String methodName,
    required String from,
    required String signer,
    required List<dynamic> args,
    int value = 0,
    bool signAndSubmit = false,
  }) async {
    final kCallContractFunctionPath =
        "chains/ethereum/addresses/$contractLabel/contracts/$contractType/methods/$methodName";

    final body = {
      "args": args,
      "from": from,
      "signer": signer,
      "signAndSubmit": signAndSubmit,
      "value": value,
      "contractOverride": false,
    };

    try {
      final response = await networkClient.postAsync<Map<String, dynamic>>(
        kCallContractFunctionPath,
        body,
      );
      return TransctionToSignResponse.fromJson(response);
    } catch (e, _) {
      rethrow;
    }
  }

  Future<HSMSubmitTransactionResponse> signAndSubmitHSMTransaction(
    web3.Transaction transaction,
  ) async {
    const kSubmitTransactionPath = "chains/ethereum/hsm/submit";
    final body = {
      "tx": {
        "gas": transaction.maxGas,
        if (transaction.gasPrice != null)
          "gasPrice": transaction.gasPrice!.getInWei.toString(),
        if (transaction.from != null) "from": transaction.from!.hex,
        if (transaction.to != null) "to": transaction.to!.hex,
        if (transaction.data != null)
          "data": bytesToHex(transaction.data!, include0x: true),
        "value": transaction.value!.getInWei.toString(),
        "type": 0,
      }
    };
    try {
      final response = await networkClient.postAsync(
        kSubmitTransactionPath,
        body,
      );

      return HSMSubmitTransactionResponse.fromJson(response);
    } catch (e, _) {
      rethrow;
    }
  }
}