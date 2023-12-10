import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;

  const AnswerButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: ButtonStyle(
        alignment: Alignment.centerLeft,
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 60),
        ),
        side: const MaterialStatePropertyAll(
          BorderSide(color: Color(0xff475467)),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
