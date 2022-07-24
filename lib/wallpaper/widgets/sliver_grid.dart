import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper/wallpaper/bloc/video_bloc.dart';
import 'package:wallpaper/wallpaper/bloc/wallpaper_bloc.dart';
import 'package:wallpaper/wallpaper/image_details.dart';
import 'package:wallpaper/wallpaper/models/video_model.dart';
import 'package:wallpaper/wallpaper/video_details.dart';

class SliverGrids extends StatelessWidget {
  final int page;
  final bool isWallpaper;

  const SliverGrids({
    Key key,
    @required this.page,
    @required this.isWallpaper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isWallpaper
        ? BlocConsumer<WallpaperBloc, WallpaperState>(
            listener: (context, state) {
              if (state is WallpaperLoaded || state is SearchLoaded) {
                return ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text("You are on page: $page"),
                      duration: Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
              }
            },
            builder: (context, state) {
              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 6.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (state is WallpaperLoading || state is SearchLoading) {
                      return Center(
                        child: SpinKitThreeBounce(
                          color: Colors.blue,
                          size: 30.0,
                        ),
                      );
                    } else if (state is WallpaperLoaded ||
                        state is SearchLoaded) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          top: 10.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value:
                                      BlocProvider.of<WallpaperBloc>(context),
                                  child: ImageDetails(
                                    imageUrl: state is SearchLoaded
                                        ? state.wallpaper[index].src.portrait
                                        : state is WallpaperLoaded
                                            ? state
                                                .wallpaper[index].src.portrait
                                            : null,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            transitionOnUserGestures: true,
                            tag: state is SearchLoaded
                                ? state.wallpaper[index].src.portrait
                                : state is WallpaperLoaded
                                    ? state.wallpaper[index].src.portrait
                                    : null,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                child: CachedNetworkImage(
                                  imageUrl: state is SearchLoaded
                                      ? state.wallpaper[index].src.portrait
                                      : state is WallpaperLoaded
                                          ? state.wallpaper[index].src.portrait
                                          : null,
                                  fadeInCurve: Curves.easeIn,
                                  fit: BoxFit.cover,
                                  fadeInDuration: Duration(seconds: 1),
                                  fadeOutCurve: Curves.decelerate,
                                  fadeOutDuration: Duration(seconds: 1),
                                  filterQuality: FilterQuality.high,
                                  // useOldImageOnUrlChange: true,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: SpinKitThreeBounce(
                                      color: Colors.blue,
                                      size: 30.0,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (state is WallpaperError ||
                        state is SearchError) {
                      return Center(
                        child: Text(
                          state is SearchError
                              ? state.error.toString()
                              : state is WallpaperError
                                  ? state.error.toString()
                                  : null,
                        ),
                      );
                    }
                    return SpinKitThreeBounce(
                      color: Colors.blue,
                      size: 30.0,
                    );
                  },
                  childCount: state is SearchLoaded
                      ? state.wallpaper.length
                      : state is WallpaperLoaded
                          ? state.wallpaper.length
                          : null,
                ),
              );
            },
          )
        : BlocConsumer<VideoBloc, VideoState>(
            listener: (context, state) {
              if (state is VideoLoaded || state is SearchVideoLoaded) {
                return ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text("You are on page: $page"),
                      duration: Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
              }
            },
            builder: (context, state) {
              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 6.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (state is VideoLoading || state is SearchVideoLoading) {
                      return Center(
                        child: SpinKitThreeBounce(
                          color: Colors.blue,
                          size: 30.0,
                        ),
                      );
                    } else if (state is VideoLoaded ||
                        state is SearchVideoLoaded) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          top: 10.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: BlocProvider.of<VideoBloc>(context),
                                  child: VideoDetails(
                                    videos: state is SearchVideoLoaded
                                        ? state.videos[index]
                                        : state is VideoLoaded
                                            ? state.videos[index]
                                            : null,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            // transitionOnUserGestures: true,
                            tag: state is SearchVideoLoaded
                                ? state.videos[index].image
                                : state is VideoLoaded
                                    ? state.videos[index].image
                                    : null,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                child: CarouselSlider(
                                  items: state is VideoLoaded
                                      ? _imageCarousel(state.videos, index)
                                      : state is SearchVideoLoaded
                                          ? _imageCarousel(state.videos, index)
                                          : Center(
                                              child: SpinKitWanderingCubes(
                                                color: Colors.blue,
                                                size: 16.0,
                                              ),
                                            ),
                                  options: CarouselOptions(
                                    height: 100,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 1.5,
                                    initialPage: 0,
                                    pauseAutoPlayOnTouch: true,
                                    disableCenter: true,
                                    reverse: false,
                                    autoPlay: true,
                                    scrollPhysics: BouncingScrollPhysics(),
                                    pageSnapping: false,
                                    autoPlayInterval: Duration(seconds: 5),
                                    autoPlayAnimationDuration:
                                        Duration(seconds: 5),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (state is VideoError ||
                        state is SearchVideoError) {
                      return Center(
                        child: Text(
                          state is SearchVideoError
                              ? state.error.toString()
                              : state is VideoError
                                  ? state.error.toString()
                                  : null,
                        ),
                      );
                    }
                    return SpinKitThreeBounce(
                      color: Colors.blue,
                      size: 30.0,
                    );
                  },
                  childCount: state is SearchVideoLoaded
                      ? state.videos.length
                      : state is VideoLoaded
                          ? state.videos.length
                          : null,
                ),
              );
            },
          );
  }

  List<Widget> _imageCarousel(List<Videos> videos, int index) {
    return videos[index]
        .videoPictures
        .map(
          (e) => CachedNetworkImage(
            imageUrl: e.picture,
            fadeInCurve: Curves.easeIn,
            fit: BoxFit.cover,
            fadeInDuration: Duration(seconds: 1),
            fadeOutCurve: Curves.decelerate,
            fadeOutDuration: Duration(seconds: 1),
            filterQuality: FilterQuality.high,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: SpinKitThreeBounce(
                color: Colors.blue,
                size: 30.0,
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        )
        .toList();
  }
}
