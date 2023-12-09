import 'package:hive_flutter/hive_flutter.dart';


const String configurationBoxKey = "configBox";
const String userAddressKey = "userAddress";
const String isSocialWalletKey = "isSocialWallet";

class HiveManager {
  const HiveManager._();

  static Box get configurationBox => Hive.box(configurationBoxKey);

  static Future<void> openBoxes() async {
    await Hive.initFlutter();
    await Hive.openBox(configurationBoxKey);
  }

  static Future<void> addData(String key, dynamic value) async {
    configurationBox.put(key, value);
  }

  static dynamic getData(String key) {
    return configurationBox.get(key);
  }
}