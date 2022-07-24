part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final List<Videos> videos;
  VideoLoaded({
    @required this.videos,
  });

  @override
  List<Object> get props => [videos];
}

class VideoError extends VideoState {
  final dynamic error;
  VideoError({
    @required this.error,
  });

  @override
  List<Object> get props => [error];
}

class SearchVideoLoading extends VideoState {}

class SearchVideoLoaded extends VideoState {
  final List<Videos> videos;
  SearchVideoLoaded({
    @required this.videos,
  });

  @override
  List<Object> get props => [videos];
}

class SearchVideoError extends VideoState {
  final dynamic error;
  SearchVideoError({
    @required this.error,
  });

  @override
  List<Object> get props => [error];
}
