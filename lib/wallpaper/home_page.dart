import 'dart:async';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper/wallpaper/bloc/internet_bloc.dart';
import 'package:wallpaper/wallpaper/image_page.dart';
import 'package:wallpaper/wallpaper/videos_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    final internetBloc = BlocProvider.of<InternetBloc>(context);

    _connectivity.checkConnectivity().then((result) =>
        internetBloc.add(GetInternetStatus(connectivityResult: result)));

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      internetBloc.add(GetInternetStatus(connectivityResult: result));
    });

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 70.0,
              elevation: 0.0,
              floating: true,
              snap: true,
              centerTitle: true,
              title: Text(
                "Wallpaper",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                controller: _tabController,
                labelPadding: EdgeInsets.all(4.0),
                indicator: BubbleTabIndicator(
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.grey[400],
                  indicatorHeight: 38.0,
                  padding: EdgeInsets.all(8.0),
                ),
                physics: BouncingScrollPhysics(),
                labelColor: Colors.black,
                unselectedLabelStyle: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[900],
                ),
                tabs: [
                  Tab(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image),
                          SizedBox(width: 4.0),
                          Text("Images"),
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.video_collection_outlined),
                          SizedBox(width: 4.0),
                          Text("Videos"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: BlocConsumer<InternetBloc, InternetState>(
          listener: (context, state) {
            if (state is InternetConnected &&
                state.connectivityResult == ConnectivityResult.wifi) {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text("Connected to Wifi"),
                  backgroundColor: Colors.greenAccent,
                  behavior: SnackBarBehavior.floating,
                ));
            } else if (state is InternetConnected &&
                state.connectivityResult == ConnectivityResult.mobile) {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text("Connected to Mobile"),
                  backgroundColor: Colors.lightGreen,
                  behavior: SnackBarBehavior.floating,
                ));
            } else {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text("Disconnected to Internet"),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                ));
            }
          },
          builder: (context, state) {
            if (state is InternetDisconnected) {
              return Center(
                child: SpinKitChasingDots(
                  color: Colors.blue,
                  size: 30.0,
                ),
              );
            }
            if (state is InternetLoading) {
              return Center(
                child: SpinKitChasingDots(
                  color: Colors.blue,
                  size: 30.0,
                ),
              );
            }
            return TabBarView(
              physics: BouncingScrollPhysics(),
              controller: _tabController,
              children: [
                ImagePage(),
                VideosPage(),
              ],
            );
          },
        ),
      ),
    );
  }
}
