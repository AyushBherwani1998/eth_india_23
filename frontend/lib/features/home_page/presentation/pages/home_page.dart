import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/app_config.dart';
import 'package:frontend/core/extensions.dart';
import 'package:frontend/core/service_locator.dart';
import 'package:frontend/core/utils/scan_util.dart';
import 'package:frontend/core/utils/web3_util.dart';
import 'package:frontend/features/home_page/domain/bloc/home_bloc_bloc.dart';
import 'package:frontend/features/home_page/presentation/widgets/empty_list.dart';
import 'package:frontend/features/home_page/presentation/widgets/nfts.dart';
import 'package:frontend/features/push/chat/presentation/pages/chat_page.dart';
import 'package:frontend/features/quest/presentation/pages/mint_page.dart';
import 'package:frontend/features/quest/presentation/widgets/loader.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ServiceLocator.getIt<HomeBloc>();
    print(AppConfig.userAddress());
    bloc.add(FetchTokenBalanceEvent(
      address: AppConfig.userAddress(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 64),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/profile.png',
                  width: 46,
                ),
                const SizedBox(width: 12),
                Column(
                  children: [
                    const Text(
                      "Welcome",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppConfig.userAddress().addressAbbreviation,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ChatPage(room: null);
                      }),
                    );
                  },
                  child: Image.asset(
                    'assets/qrcode.png',
                    width: 46,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeBlocState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is HomeBlocSuccessState) {
                  if (state.tokenBalanceResponse.isEmpty) {
                    return const EmptyList();
                  }
                  return NFTsListView(nfts: state.tokenBalanceResponse);
                }
                return const Loader();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> scanAndMintNFT(BuildContext context) async {
    final response = await QRScanUtil.scan(
      context,
      title: "Scan Invite QR",
    );
    final label = response.first;

    if (context.mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MintPage(contractLabel: label, contractType: 'soulbound');
      }));
    }
  }
}
