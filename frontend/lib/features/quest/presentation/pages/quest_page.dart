import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/colors.dart';
import 'package:frontend/features/quest/domain/models/quest_model.dart';
import 'package:frontend/features/quest/presentation/widgets/quest_tile.dart';

class QuestPage extends StatefulWidget {
  const QuestPage({super.key});

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
      ),
      body: Padding(
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
            const Text(
              "Activities",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
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
                title: "🗣️ Learn",
                description: "Listen to Vitalik’s talk",
                rewards: "You earn a Alt T-shirt NFT and T-shirt",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            QuestTile(
              index: 3,
              questModel: QuestModel(
                title: "🗣️ Learn",
                description: "Listen to Vitalik’s talk",
                rewards: "You earn a Alt T-shirt NFT and T-shirt",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
