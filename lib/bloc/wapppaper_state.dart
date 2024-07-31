part of 'wapppaper_bloc.dart';

sealed class WallpaperState extends Equatable {
  const WallpaperState();

  @override
  List<Object> get props => [];
}

final class WallpaperInitialState extends WallpaperState {}

final class WallpaperLoadingState extends WallpaperState {}

final class WallpaperLoadedState extends WallpaperState {
  final List<PhotoModel> photomodel;

  const WallpaperLoadedState({required this.photomodel});
  @override
  List<Object> get props => [photomodel];
}

final class WallpaperErrorSate extends WallpaperState {
  final String errorMsg;

  const WallpaperErrorSate({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

final class InternetLostState extends WallpaperState{}

final class InternetGainState extends WallpaperState{}





