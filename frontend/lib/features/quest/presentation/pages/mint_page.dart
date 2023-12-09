import 'package:flutter/material.dart';
import 'package:frontend/core/curve_grid/curve_grid_provider.dart';
import 'package:frontend/core/service_locator.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/features/quest/presentation/widgets/loader.dart';

class MintPage extends StatefulWidget {
  final String contractLabel;
  final bool isPoap;

  const MintPage({
    super.key,
    required this.contractLabel,
    this.isPoap = false,
  });

  @override
  State<MintPage> createState() => _MintPageState();
}

class _MintPageState extends State<MintPage> {
  late final Future mintFuture;
  late final CurveGridProvider curveGridProvider;

  @override
  void initState() {
    super.initState();
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
    mintFuture = Future.delayed(const Duration(seconds: 3));
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

          return const Loader();
        },
      ),
    );
  }
}
