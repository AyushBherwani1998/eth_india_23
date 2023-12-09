import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/core/app_config.dart';
import 'package:frontend/core/extensions.dart';
import 'package:frontend/features/home_page/domain/models/nft_balance.dart';
import 'package:frontend/features/quest/presentation/pages/quest_page.dart';

class NFTsListView extends StatelessWidget {
  final List<NFTBalanceResponse> nfts;

  const NFTsListView({super.key, required this.nfts});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "You are attending",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: nfts.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return QuestPage(title: nfts[index].collectionName);
                      }),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xff1D2939),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    width: width,
                    height: width,
                    child: SvgPicture.asset('assets/add.svg'),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
