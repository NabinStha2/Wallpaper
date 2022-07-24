import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/wallpaper/bloc/video_bloc.dart';
import 'package:wallpaper/wallpaper/bloc/wallpaper_bloc.dart';
import 'package:wallpaper/wallpaper/widgets/sliver_grid.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  final bool isWallpaper;

  const Search({
    Key key,
    @required this.searchQuery,
    @required this.isWallpaper,
  }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: 0,
    keepScrollOffset: true,
  );
  int pageSearch = 1;

  @override
  void initState() {
    searchController.text = widget.searchQuery;
    if (widget.isWallpaper) {
      BlocProvider.of<WallpaperBloc>(context).add(GetSearchEvent(
        fromInsideSearch: false,
        query: searchController.text,
        page: pageSearch,
      ));
    } else {
      BlocProvider.of<VideoBloc>(context).add(GetSearchVideos(
        fromInsideSearch: false,
        query: searchController.text,
        page: pageSearch,
      ));
    }

    _scrollController.addListener(() {
      // print("pageCategory: $pageSearch");
      // print(searchController.text);

      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0) {
        setState(() {
          pageSearch = pageSearch + 1;
        });

        if (widget.isWallpaper) {
          BlocProvider.of<WallpaperBloc>(context).add(GetSearchEvent(
            fromInsideSearch: false,
            query: searchController.text,
            page: pageSearch,
          ));
        } else {
          BlocProvider.of<VideoBloc>(context).add(GetSearchVideos(
            fromInsideSearch: false,
            query: searchController.text,
            page: pageSearch,
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
            child: _buildUpperContent(),
          ),
          SliverGrids(
            page: pageSearch,
            isWallpaper: widget.isWallpaper,
          ),
        ],
      ),
    );
  }

  Widget _buildUpperContent() {
    return Column(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(30.0),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Expanded(
                // flex: 2,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    enabled: true,
                    hintText: "Search...",
                    hintStyle: TextStyle(
                      decorationStyle: TextDecorationStyle.solid,
                      decoration: TextDecoration.none,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    pageSearch = 1;
                  });
                  if (widget.isWallpaper) {
                    BlocProvider.of<WallpaperBloc>(context).add(GetSearchEvent(
                      fromInsideSearch: true,
                      query: searchController.text,
                      page: pageSearch,
                    ));
                  } else {
                    BlocProvider.of<VideoBloc>(context).add(GetSearchVideos(
                      fromInsideSearch: true,
                      query: searchController.text,
                      page: pageSearch,
                    ));
                  }
                },
                child: Icon(Icons.search),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Made By:"),
            Text(
              "Nabin Shrestha",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Page No: "),
            Text(
              "$pageSearch",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
