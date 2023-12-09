import 'package:frontend/core/hive_manager.dart';

class AppConfig {
  const AppConfig._();

  static bool isFirstTimeUser() {
    return HiveManager.getData(userAddressKey) == null;
  }

  static Future<void> saveUserAddress(String address) async {
    return await HiveManager.addData(userAddressKey, address);
  }

  static bool isSocialWallet() {
    return HiveManager.getData(isSocialWalletKey);
  }

  static Future<void> saveWalletType(isSocialWallet) async {
    return await HiveManager.addData(isSocialWalletKey, isSocialWallet);
  }

  static String userAddress() {
    final address = HiveManager.getData(userAddressKey);
    return address as String;
  }
}