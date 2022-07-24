import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/wallpaper/bloc/video_bloc.dart';
import 'package:wallpaper/wallpaper/bloc/wallpaper_bloc.dart';
import 'package:wallpaper/wallpaper/widgets/sliver_grid.dart';

class Category extends StatefulWidget {
  final String categoryName;
  final bool isWallpaper;
  const Category({
    Key key,
    @required this.categoryName,
    @required this.isWallpaper,
  }) : super(key: key);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: 0,
    keepScrollOffset: true,
  );
  int pageCategory = 1;

  @override
  void initState() {
    print("category: ${widget.categoryName}");

    if (widget.isWallpaper) {
      BlocProvider.of<WallpaperBloc>(context).add(GetSearchEvent(
        fromInsideSearch: false,
        query: widget.categoryName,
        page: pageCategory,
      ));
    } else {
      BlocProvider.of<VideoBloc>(context).add(GetSearchVideos(
        fromInsideSearch: false,
        query: widget.categoryName,
        page: pageCategory,
      ));
    }

    _scrollController.addListener(() {
      print("pageCategory: $pageCategory");
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0) {
        setState(() {
          pageCategory = pageCategory + 1;
        });
        if (widget.isWallpaper) {
          BlocProvider.of<WallpaperBloc>(context).add(GetSearchEvent(
            fromInsideSearch: false,
            query: widget.categoryName,
            page: pageCategory,
          ));
        } else {
          BlocProvider.of<VideoBloc>(context).add(GetSearchVideos(
            fromInsideSearch: false,
            query: widget.categoryName,
            page: pageCategory,
          ));
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 60.0,
            floating: true,
            snap: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                if (widget.isWallpaper) {
                  BlocProvider.of<WallpaperBloc>(context)
                      .add(RefreshWallpaper());
                  BlocProvider.of<WallpaperBloc>(context).add(GetWallpaper(
                    page: 1,
                  ));
                } else {
                  BlocProvider.of<VideoBloc>(context).add(RefreshVideos());
                  BlocProvider.of<VideoBloc>(context).add(GetVideos(
                    page: 1,
                  ));
                }
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Wallpaper",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Page No: "),
                Text(
                  "$pageCategory",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          SliverGrids(
            page: pageCategory,
            isWallpaper: widget.isWallpaper,
          ),
        ],
      ),
    );
  }
}
