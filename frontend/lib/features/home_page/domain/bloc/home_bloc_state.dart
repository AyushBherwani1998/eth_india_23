part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeBlocState {}

final class HomeBlocInitial extends HomeBlocState {}

final class HomeBlocSuccessState extends HomeBlocState {
  final List<NFTBalanceResponse> tokenBalanceResponse;

  HomeBlocSuccessState({required this.tokenBalanceResponse});
  
}

final class HomeBlocErrorState extends HomeBlocState {
  final String error;

  HomeBlocErrorState({required this.error});
}
