import 'package:flutter/material.dart';
import 'package:frontend/core/app_config.dart';
import 'package:frontend/core/service_locator.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/features/home_page/presentation/pages/home_page.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final W3MService w3mService;

  @override
  void initState() {
    super.initState();
    w3mService = ServiceLocator.getIt<W3MService>();
    w3mService.web3App?.onSessionConnect.subscribe((args) {
      onWalletConnectConnected(args, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Image.asset(
            'assets/logo.png',
            width: 200,
          ),
          const Spacer(),
          AppButton(
            onTap: () async {
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return const QuestPage(
              //     title: "Polygon Connect",
              //   );
              // }));
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return const HomePage();
              // }));
              // final response = await QRScanUtil.scan(
              //   context,
              //   title: "Scan Invite QR",
              // );
              // print(response);

              // final curveGrid = ServiceLocator.getIt<CurveGridProvider>();
              // curveGrid
              //     .callContractWriteFunction(
              //       contractLabel: "q",
              //       contractType: "q",
              //       methodName: "safeMint",
              //       from: "0x6d66b909636b4f0C179cb50a3710B3ab614dD67a",
              //       signer: "0x6d66b909636b4f0C179cb50a3710B3ab614dD67a",
              //       args: ["0x6d66b909636b4f0C179cb50a3710B3ab614dD67a"],
              //       signAndSubmit: true,
              //     )
              //     .then((value) => value)
              //     .catchError((_) {
              //   print(_);
              // });
              socialLogin(context);
            },
            buttonText: "Contiue with Google",
          ),
          const SizedBox(height: 16),
          AppButton(
            onTap: () {
              walletConnectLogin(context);
            },
            buttonColor: Colors.white,
            textColor: Colors.black,
            buttonText: "Contiue with existing wallet",
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<void> walletConnectLogin(BuildContext context) async {
    w3mService.openModal(context);
  }

  void onWalletConnectConnected(SessionConnect? args, BuildContext context) {
    if (w3mService.isConnected) {
      AppConfig.saveUserAddress(w3mService.address!);
      AppConfig.saveWalletType(false);
      navigateToHomePage(context);
    }
  }

  void navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));
  }

  Future<void> socialLogin(BuildContext context) async {
    try {
      await Web3AuthFlutter.login(
        LoginParams(
          loginProvider: Provider.google,
          mfaLevel: MFALevel.NONE,
        ),
      );
      final privateKey = await Web3AuthFlutter.getPrivKey();
      final key = EthPrivateKey.fromHex(privateKey);
      AppConfig.saveUserAddress(key.address.hex);
      AppConfig.saveWalletType(false);
      if (context.mounted) {
        navigateToHomePage(context);
      }
    } catch (e, _) {
      print(e);
    }
  }
}
