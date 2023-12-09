import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/colors.dart';
import 'package:frontend/features/quest/presentation/widgets/answer_button.dart';
import 'package:frontend/features/quest/presentation/widgets/loader.dart';

class QuestionnairePage extends StatefulWidget {
  final String contractAddress;
  final String contractLabel;

  const QuestionnairePage({
    super.key,
    required this.contractAddress,
    required this.contractLabel,
  });

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  late final Future future;

  @override
  void initState() {
    super.initState();
    future = Future.delayed(
      Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: appBarColor,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.xmark,
            size: 20,
          ),
        ),
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "Is Celo EVM based chain?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 32),
                  AnswerButton(buttonText: "Yes", onTap: () {}),
                  const SizedBox(height: 16),
                  AnswerButton(buttonText: "No", onTap: () {}),
                  const Spacer(),
                ],
              ),
            );
          }
          return const Loader();
        },
      ),
    );
  }
}
