import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web3modal_flutter/web3modal_flutter.dart';

import 'wallet_connect/utils/namespace_utils.dart';

class ServiceLocator {
  const ServiceLocator._();

  static GetIt get getIt => GetIt.instance;

  static Future<void> init() async {
    // final Web3Client web3client = Web3Client(
    //   dotenv.env["RPC_URL"] as String,
    //   http.Client(),
    // );

    // getIt.registerLazySingleton<Web3Client>(() => web3client);

    const pairingMetaData = PairingMetadata(
      name: 'Adventure Runner',
      description:
          'Adventure runner is a game developed at Eth Global Istanbul',
      url: 'https://github.com/AyushBherwani1998/eth_global_istanbul',
      icons: ['https://walletconnect.com/walletconnect-logo.png'],
    );

    getIt.registerLazySingleton<PairingMetadata>(() => pairingMetaData);

    final walletConnectModalService = W3MService(
      projectId:dotenv.env['WALLET_CONNECT_PROJECT_ID'] as String ,
      requiredNamespaces: prepareRequiredNameSpace(),
      metadata: getIt<PairingMetadata>(),
    );

    await walletConnectModalService.init();

    getIt.registerLazySingleton<W3MService>(
      () => walletConnectModalService,
    );
  }
}