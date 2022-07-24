part of 'wallpaper_bloc.dart';

abstract class WallpaperEvent extends Equatable {
  const WallpaperEvent();

  @override
  List<Object> get props => [];
}

class GetWallpaper extends WallpaperEvent {
  final int page;

  GetWallpaper({this.page});

  @override
  List<Object> get props => [page];
}

class RefreshWallpaper extends WallpaperEvent {}

class GetSearchEvent extends WallpaperEvent {
  final String query;
  final int page;
  final bool fromInsideSearch;
  GetSearchEvent({
    @required this.query,
    @required this.page,
    @required this.fromInsideSearch,
  });

  @override
  List<Object> get props => [query];
}

// class GetInsideSearch extends WallpaperEvent {
//   final String query;
//   final int page;
//   GetInsideSearch({
//     @required this.query,
//     @required this.page,
//   });

//   @override
//   List<Object> get props => [query];
// }
