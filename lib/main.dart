import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper/wallpaper/bloc/internet_bloc.dart';
import 'package:wallpaper/wallpaper/bloc/video_bloc.dart';
import 'package:wallpaper/wallpaper/bloc/wallpaper_bloc.dart';
import 'package:wallpaper/wallpaper/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WallpaperBloc>(
          create: (context) => WallpaperBloc(),
        ),
        BlocProvider<VideoBloc>(
          create: (context) => VideoBloc(),
        ),
        BlocProvider<InternetBloc>(
          create: (context) => InternetBloc(),
        ),
      ],
      child: MaterialApp(
        title: "Wallpaper",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          // textTheme: GoogleFonts.poppinsTextTheme(),
          fontFamily: GoogleFonts.poppins().fontFamily,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: Theme.of(context).textTheme,
        ),
        home: AnimatedSplashScreen(
          splash: Container(
            alignment: Alignment.center,
            child: ClipRRect(
              child: Image.asset(
                "assets/images/wallpaper.jpg",
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          nextScreen: HomePage(),
          animationDuration: Duration(seconds: 3),
          backgroundColor: Colors.white,
          curve: Curves.bounceOut,
          splashIconSize: 250,
          centered: true,
          splashTransition: SplashTransition.rotationTransition,
        ),
      ),
    );
  }
}
