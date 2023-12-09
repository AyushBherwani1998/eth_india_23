import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/home_page/domain/data/provider.dart';
import 'package:frontend/features/home_page/domain/models/nft_balance.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBloc() : super(HomeBlocInitial()) {
    on<HomeBlocEvent>((event, emit) async {
      if (event is FetchTokenBalanceEvent) {
        final state = await event.applyAsync(
          currentState: this.state,
          bloc: this,
        );

        emit(state);
      }
    });
  }
}
