import 'package:frontend/features/home_page/domain/models/nft_balance.dart';
import 'package:frontend/features/home_page/domain/models/test.dart';

abstract class IHomePageProvider {
  Future<TokenBalanceResponse> fetchTokens(String address);
}

class HomePageProvider extends IHomePageProvider {
  @override
  Future<TokenBalanceResponse> fetchTokens(String address) {
    Future.delayed(const Duration(seconds: 1));
    final response = TokenBalanceResponse.fromJson(tokenBalanceMap);
    return Future.value(response);
  }
}
