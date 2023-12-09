import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/app_config.dart';
import 'package:frontend/core/colors.dart';
import 'package:frontend/core/service_locator.dart';
import 'package:frontend/features/home_page/domain/bloc/home_bloc_bloc.dart';
import 'package:frontend/features/quest/domain/models/quest_model.dart';
import 'package:frontend/features/quest/presentation/widgets/loader.dart';
import 'package:frontend/features/quest/presentation/widgets/nft_grid_list.dart';
import 'package:frontend/features/quest/presentation/widgets/quest_info.dart';
import 'package:frontend/features/quest/presentation/widgets/quest_tile.dart';

class QuestPage extends StatefulWidget {
  final String title;
  const QuestPage({super.key, required this.title});

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  late final ValueNotifier<String> selectedTab;
  late final HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    selectedTab = ValueNotifier<String>("quests");
    homeBloc = ServiceLocator.getIt<HomeBloc>();
    homeBloc.add(FetchTokenBalanceEvent(
      address: "0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Offstage(),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: appBarColor,
        elevation: 0,
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: selectedTab,
        builder: (context, tab, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Placeholder(
                      fallbackHeight: 80,
                      fallbackWidth: 80,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Redeem NFT’s & Earn merch",
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Maximise your events experience",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                CupertinoSlidingSegmentedControl(
                  onValueChanged: (value) {
                    selectedTab.value = value!;
                  },
                  groupValue: selectedTab.value,
                  children: const {
                    "quests": Text(
                      "Quests",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    "owned": Text(
                      "Owned NFT",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  },
                ),
                const SizedBox(height: 16),
                if (selectedTab.value == "quests") ...[
                  const Expanded(child: QuestInfoWidget()),
                ],
                if (selectedTab.value == "owned") ...[
                  Expanded(
                    child: BlocBuilder<HomeBloc, HomeBlocState>(
                      bloc: homeBloc,
                      builder: (context, state) {
                        if (state is HomeBlocSuccessState) {
                          return NFTGridList(
                            nfts: state.tokenBalanceResponse,
                          );
                        }

                        return const Loader();
                      },
                    ),
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}
