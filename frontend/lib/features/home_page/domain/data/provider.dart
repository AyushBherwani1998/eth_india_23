import 'package:frontend/core/network/app_client.dart';
import 'package:frontend/features/home_page/domain/models/nft_balance.dart';

abstract class IHomePageProvider {
  Future<List<NFTBalanceResponse>> fetchTokens(String address);

  final appNetworkClient = AppNetworkClient();
}

class HomePageProvider extends IHomePageProvider {
  @override
  Future<List<NFTBalanceResponse>> fetchTokens(String address) async {
    Future.delayed(const Duration(seconds: 1));
    final path = "polygon/address/$address/balance";

    try {
      final response = await appNetworkClient.getAsync<List>(path);
      final tokens =
          response.map((e) => NFTBalanceResponse.fromJson(e)).toList();
      return tokens;
    } catch (e, _) {
      rethrow;
    }
  }
}
