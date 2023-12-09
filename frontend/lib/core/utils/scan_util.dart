import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/features/scan/presentation/scan/scan_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

mixin QRScanUtil {
  static Future<List> scan(
    BuildContext context, {
    required String title,
  }) async {
    final List<dynamic> barcodeResult = List<dynamic>.filled(
      3,
      null,
      growable: false,
    );

    final Barcode? res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ScanPage(title: title);
      }),
    );
    if (res != null && res.code != null) {
      final String content = res.code!;
      final startIndex = content.contains(RegExp(r'://'))
          ? content.lastIndexOf(RegExp(r'://')) + 3
          : 0;
      barcodeResult[0] = content.substring(startIndex);
      barcodeResult[1] = true;
      barcodeResult[2] = res.format.formatName;
      return barcodeResult;
    }
    barcodeResult[0] = "Something went wrong";
    barcodeResult[1] = false;
    barcodeResult[2] = "Some error occured";
    return barcodeResult;
  }
}
