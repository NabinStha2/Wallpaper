part of 'wallpaper_bloc.dart';

abstract class WallpaperState extends Equatable {
  const WallpaperState();

  @override
  List<Object> get props => [];
}

class WallpaperInitial extends WallpaperState {}

class WallpaperLoading extends WallpaperState {}

class WallpaperLoaded extends WallpaperState {
  final List<WallpaperModel> wallpaper;
  WallpaperLoaded({
    @required this.wallpaper,
  });

  @override
  List<Object> get props => [wallpaper];
}

class WallpaperError extends WallpaperState {
  final dynamic error;
  WallpaperError({
    @required this.error,
  });

  @override
  List<Object> get props => [error];
}

class SearchLoading extends WallpaperState {}

class SearchLoaded extends WallpaperState {
  final List<WallpaperModel> wallpaper;
  SearchLoaded({
    @required this.wallpaper,
  });

  @override
  List<Object> get props => [wallpaper];
}

class SearchLengthZero extends WallpaperState {}

class SearchError extends WallpaperState {
  final dynamic error;
  SearchError({
    @required this.error,
  });

  @override
  List<Object> get props => [error];
}
