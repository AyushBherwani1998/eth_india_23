import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/service_locator.dart';
import 'package:frontend/features/push/chat/presentation/pages/chat_page.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();
  final Uri redirectUrl;
  if (Platform.isAndroid) {
    redirectUrl = Uri.parse('demo://com.example.frontend/auth');
  } else {
    redirectUrl = Uri.parse('com.example.ethindia://auth');
  }

  await Web3AuthFlutter.init(
    Web3AuthOptions(
      clientId:
          "BKfy65BfRVVPEs3EP28xSLnzWfqLqN4b8N2ZjUQ5JU6UG7DklWsmwJ0Z-TPHdC5mg23SVuoE4u6l-8IwB6oLAh4",
      network: Network.sapphire_devnet,
      buildEnv: BuildEnv.production,
      redirectUrl: redirectUrl,
      whiteLabel: WhiteLabelData(
        appName: "ETH India",
        mode: ThemeModes.dark,
        useLogoLoader: true,
      ),
    ),
  );

  await Web3AuthFlutter.initialize();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProviderScope(child: ChatPage(room: null)),
    );
  }
}
