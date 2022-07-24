import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/wallpaper/bloc/video_bloc.dart';
import 'package:wallpaper/wallpaper/category.dart';
import 'package:wallpaper/wallpaper/models/categories_model.dart';
import 'package:wallpaper/wallpaper/search.dart';
import 'package:wallpaper/wallpaper/widgets/sliver_grid.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  final TextEditingController searchController = new TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    // print("VideoPage: $page");

    BlocProvider.of<VideoBloc>(context).add(RefreshVideos());
    BlocProvider.of<VideoBloc>(context).add(GetVideos(page: page));

    Future.delayed(Duration(seconds: 2), () {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text("Slide the image."),
            behavior: SnackBarBehavior.floating,
          ),
        );
    });

    _scrollController.addListener(() {
      // print("page: $page");
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0) {
        setState(() {
          page = page + 1;
        });
        BlocProvider.of<VideoBloc>(context).add(GetVideos(page: page));
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.blue[300],
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 3), () {
          setState(() {
            page = 1;
          });
          BlocProvider.of<VideoBloc>(context).add(RefreshVideos());
          BlocProvider.of<VideoBloc>(context).add(GetVideos(page: page));
        });
      },
      child: Builder(
        builder: (context) => CustomScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _buildUpperContent(),
            ),
            SliverGrids(
              page: page,
              isWallpaper: false,
            ),
          ],
        ),
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
                  autofocus: false,
                  enableSuggestions: true,
                  decoration: InputDecoration(
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
                onTap: () async {
                  if (searchController.text == "") {
                    return await showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('search must not be null!'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<VideoBloc>(context),
                        child: Search(
                          searchQuery: searchController.text,
                          isWallpaper: false,
                        ),
                      ),
                    ),
                  );
                },
                child: Icon(Icons.search),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text("Made By:"),
        //     Text(
        //       "Nabin Shrestha",
        //       style: TextStyle(
        //         color: Colors.blue,
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 10.0,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Page No: "),
            Text(
              "$page",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          height: MediaQuery.of(context).size.height * 0.07,
          child: ListView.builder(
            itemCount: getCategories.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    page = 1;
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<VideoBloc>(context),
                        child: Category(
                          categoryName: getCategories[index].title,
                          isWallpaper: false,
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        // child: Image.network(
                        //   getCategories[index].imageUrl,
                        //   width: MediaQuery.of(context).size.width * 0.35,
                        //   fit: BoxFit.cover,
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: getCategories[index].imageUrl,
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          fadeInDuration: Duration(seconds: 1),
                          fadeOutCurve: Curves.decelerate,
                          fadeOutDuration: Duration(seconds: 1),
                          filterQuality: FilterQuality.high,
                          useOldImageOnUrlChange: true,
                          width: MediaQuery.of(context).size.width * 0.35,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        alignment: Alignment.center,
                        child: Text(
                          getCategories[index].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
