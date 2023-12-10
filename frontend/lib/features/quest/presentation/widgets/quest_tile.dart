import 'package:flutter/material.dart';
import 'package:frontend/features/quest/domain/models/quest_model.dart';

class QuestTile extends StatelessWidget {
  final int index;
  final QuestModel questModel;

  const QuestTile({
    super.key,
    required this.index,
    required this.questModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            "${index.toString()}.",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: const Color(0xFF344054),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  questModel.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  questModel.description,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(
                  thickness: 1,
                  color: Color(0xFF344054),
                ),
                const SizedBox(height: 8),
                Text(
                  questModel.rewards,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
