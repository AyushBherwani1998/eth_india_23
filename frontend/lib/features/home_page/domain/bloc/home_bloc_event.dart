part of 'home_bloc_bloc.dart';

sealed class HomeBlocEvent {
  Future<HomeBlocState> applyAsync({
    required HomeBlocState currentState,
    required HomeBloc bloc,
  });
}

class FetchTokenBalanceEvent extends HomeBlocEvent {
  final String address;

  FetchTokenBalanceEvent({required this.address});

  @override
  Future<HomeBlocState> applyAsync({
    required HomeBlocState currentState,
    required HomeBloc bloc,
  }) async {
    try {
      final IHomePageProvider homePageProvider = HomePageProvider();
      final reponse = await homePageProvider.fetchTokens(address);
      return HomeBlocSuccessState(tokenBalanceResponse: reponse);
    } catch (e, _) {
      return HomeBlocErrorState(error: "error");
    }
  }
}
