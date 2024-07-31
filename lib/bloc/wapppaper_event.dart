// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'wapppaper_bloc.dart';

sealed class WallpaperEvent extends Equatable {
  const WallpaperEvent();

  @override
  List<Object> get props => [];
}

class WallpaperLoadedEvent extends WallpaperEvent {}

class WallpaperSearchEvent extends WallpaperEvent {
  final String searchPhoto;
  const WallpaperSearchEvent({
    required this.searchPhoto,
  });

  @override
  List<Object> get props => [searchPhoto];
}

class TextClearEvent extends WallpaperEvent {}

class WallpaperLoadMoreEvent extends WallpaperEvent {
  final String searchPhoto;
  final int page;
  const WallpaperLoadMoreEvent({
    required this.searchPhoto,
    required this.page,
  });

  @override
  List<Object> get props => [searchPhoto, page];
}


class InternetLostEvent extends WallpaperEvent{}
class InternetGainEvent extends WallpaperEvent{}
