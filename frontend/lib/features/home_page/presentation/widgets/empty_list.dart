import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/core/colors.dart';
import 'package:frontend/core/utils/scan_util.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          GestureDetector(
            child: SvgPicture.asset('assets/add.svg'),
            onTap: () async {
              final response = await QRScanUtil.scan(
                context,
                title: "Scan invite QR",
              );
              print(response);
            },
          ),
          const SizedBox(height: 32),
          const Text(
            "Scan your event QR",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: purpleColor,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
