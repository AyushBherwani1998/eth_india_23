import 'package:frontend/core/service_locator.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class WalletConnectHandler {
  const WalletConnectHandler._();

  static W3MService get walletConnectService =>
      ServiceLocator.getIt<W3MService>();

  static Future<String> signTransaction(
    Transaction transaction,
    int chainId,
  ) async {
    final params = {
      "from": transaction.from!.hex,
      "to": transaction.to!.hex,
      "value": transaction.value!.getInWei.toRadixString(16),
      "data": bytesToHex(transaction.data!),
    };

    await walletConnectService.launchConnectedWallet();
    final signedTransaction = await walletConnectService.web3App!.request(
      topic: walletConnectService.session!.topic,
      chainId: "eip155:$chainId",
      request: SessionRequestParams(
        method: "eth_signTransaction",
        params: [params],
      ),
    );

    return signedTransaction;
  }
}