import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper/models/wallpaper_model.dart';
import 'package:wallpaper/wallpaper/repo/wallpaper_repo.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  WallpaperBloc() : super(WallpaperInitial());

  final WallpaperRepo _wallpaperRepo = WallpaperRepo();
  final List<WallpaperModel> oldWallpaper = [];
  final List<WallpaperModel> oldSearchWallpaper = [];

  @override
  Stream<WallpaperState> mapEventToState(
    WallpaperEvent event,
  ) async* {
    if (event is GetWallpaper) {
      yield WallpaperLoading();
      try {
        // print(event.page);
        final wallpaper = await _wallpaperRepo.getWallpaper(page: event.page);

        oldWallpaper.addAll(wallpaper.wallpaperModel);

        yield WallpaperLoaded(wallpaper: oldWallpaper);
      } catch (e) {
        yield WallpaperError(error: e);
      }
    } else if (event is GetSearchEvent) {
      yield SearchLoading();
      // print("bloc: ${event.query}");
      try {
        if (event.fromInsideSearch) {
          // print("clear Search");
          oldSearchWallpaper.clear();
        }
        final wallpaper = await _wallpaperRepo.getSearchWallpaper(
            searchQuery: event.query, page: event.page);
        oldSearchWallpaper.addAll(wallpaper.wallpaperModel);

        yield SearchLoaded(wallpaper: oldSearchWallpaper);
      } catch (e) {
        yield SearchError(error: e);
      }
    } else if (event is RefreshWallpaper) {
      oldSearchWallpaper.clear();
      oldWallpaper.clear();
    }
  }
}
