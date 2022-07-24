part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class GetVideos extends VideoEvent {
  final int page;

  GetVideos({this.page});

  @override
  List<Object> get props => [page];
}

class GetSearchVideos extends VideoEvent {
  final int page;
  final String query;
  final bool fromInsideSearch;
  GetSearchVideos({
    @required this.page,
    @required this.query,
    @required this.fromInsideSearch,
  });

  @override
  List<Object> get props => [page, query, fromInsideSearch];
}

class RefreshVideos extends VideoEvent {}
