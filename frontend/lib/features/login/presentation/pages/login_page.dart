import 'package:flutter/material.dart';
import 'package:frontend/core/service_locator.dart';
import 'package:frontend/core/utils/scan_util.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/features/quest/presentation/pages/quest_page.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          const Text(
            "ALT-NFT",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            "Attend Learn Talk Earn NFT",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          AppButton(
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return QuestPage();
              }));
              // final response = await QRScanUtil.scan(
              //   context,
              //   title: "Scan Invite QR",
              // );
              // print(response);
              // socialLogin(context);
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
    ServiceLocator.getIt<W3MService>().openModal(context);
  }

  Future<void> socialLogin(BuildContext context) async {
    await Web3AuthFlutter.login(
      LoginParams(
        loginProvider: Provider.google,
        mfaLevel: MFALevel.NONE,
      ),
    );
  }
}
