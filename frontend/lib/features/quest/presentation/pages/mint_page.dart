import 'package:flutter/material.dart';
import 'package:frontend/core/curve_grid/curve_grid_provider.dart';
import 'package:frontend/core/curve_grid/models/transaction_to_sign_response.dart';
import 'package:frontend/core/service_locator.dart';
import 'package:frontend/core/widgets/app_button.dart';

class MintPage extends StatefulWidget {
  final String contractLabel;
  const MintPage({
    super.key,
    required this.contractLabel,
  });

  @override
  State<MintPage> createState() => _MintPageState();
}

class _MintPageState extends State<MintPage> {
  late final Future mintFuture;
  late final CurveGridProvider curveGridProvider;

  @override
  void initState() {
    curveGridProvider = ServiceLocator.getIt<CurveGridProvider>();
    // mintFuture = curveGridProvider.callContractWriteFunction(
    //   contractLabel: widget.contractLabel,
    //   contractType: 'q',
    //   methodName: "safeMint",
    //   from: "from",
    //   signer: "signer",
    //   args: ["args"],
    //   signAndSubmit: true,
    // );
    mintFuture = Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: mintFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/success.gif',
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                AppButton(
                  onTap: () {},
                  buttonText: "Done",
                ),
                const SizedBox(height: 32)
              ],
            );
          }

          return Center(
              child: Image.asset(
            'assets/loading.gif',
            height: 100,
            width: 100,
          ));
        },
      ),
    );
  }
}
