// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import 'package:wallpaperapp/model/photo_model.dart';
import 'package:wallpaperapp/repository/repository.dart';
part 'wapppaper_event.dart';
part 'wapppaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  Connectivity connectivity = Connectivity();

  StreamSubscription? connectivitySubscription;
  final Repository repository;

  WallpaperBloc({required this.repository}) : super(WallpaperInitialState()) {
    on<WallpaperSearchEvent>((event, emit) async {
      emit(WallpaperLoadingState());
      final result = await repository.getWallPaper(event.searchPhoto);
      result.fold(
        (data) => emit(WallpaperLoadedState(photomodel: data)),
        (error) => emit(WallpaperErrorSate(errorMsg: error)),
      );
    });

    on<InternetGainEvent>(
      (event, emit) {
        emit(InternetGainState());
      },
    );

    on<InternetLostEvent>(
      (event, emit) {
        emit(InternetLostState());
      },
    );

    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetGainEvent());
      } else {
        add(InternetLostEvent());
      }
    });

    on<TextClearEvent>((event, emit) async {
      emit(WallpaperInitialState());
    });
  }
  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
