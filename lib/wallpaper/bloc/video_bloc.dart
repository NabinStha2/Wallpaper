import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper/models/video_model.dart';
import 'package:wallpaper/wallpaper/repo/video_repo.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial());

  final VideoRepo _videoRepo = VideoRepo();
  final List<Videos> oldVideos = [];
  final List<Videos> oldSearchVideos = [];

  @override
  Stream<VideoState> mapEventToState(
    VideoEvent event,
  ) async* {
    if (event is GetVideos) {
      yield VideoLoading();
      try {
        // print(event.page);
        final videoModel = await _videoRepo.getVideo(page: event.page);

        oldVideos.addAll(videoModel.videos);
        print(oldVideos.length);

        yield VideoLoaded(
          videos: oldVideos,
        );
      } catch (e) {
        yield VideoError(error: e);
      }
    } else if (event is GetSearchVideos) {
      yield SearchVideoLoading();
      print("bloc: ${event.query}");
      try {
        if (event.fromInsideSearch) {
          // print("clear Search");
          oldSearchVideos.clear();
        }
        final videoModel = await _videoRepo.getSearchVideos(
          searchQuery: event.query,
          page: event.page,
        );
        oldSearchVideos.addAll(videoModel.videos);
        yield SearchVideoLoaded(videos: oldSearchVideos);
      } catch (e) {
        yield SearchVideoError(error: e);
      }
    } else if (event is RefreshVideos) {
      oldSearchVideos.clear();
      oldVideos.clear();
    }
  }
}
