import 'package:flutter/material.dart';
import 'package:frontend/features/quest/domain/models/quest_model.dart';
import 'package:frontend/features/quest/presentation/widgets/quest_tile.dart';

class QuestInfoWidget extends StatelessWidget {
  const QuestInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          QuestTile(
            index: 1,
            questModel: QuestModel(
              title: "🗣️ Learn",
              description: "Listen to Vitalik’s talk",
              rewards: "You earn a Alt T-shirt NFT and T-shirt",
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          QuestTile(
            index: 2,
            questModel: QuestModel(
              title: "🤝 Network",
              description:
                  "Connect with 2 people present in the event using Push chat",
              rewards: "You earn a Alt socks NFT and 1inch Socks",
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          QuestTile(
            index: 3,
            questModel: QuestModel(
              title: "🧠 Know new protocols",
              description:
                  "Chat with 2 or more protocol booth, knowing more about them",
              rewards: "You earn a Alt T-shirt NFT and T-shirt",
            ),
          )
        ],
      ),
    );
  }
}
