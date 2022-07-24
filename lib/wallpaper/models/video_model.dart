import 'dart:convert';

import 'package:flutter/material.dart';

class VideoModel {
  List<Videos> videos;
  VideoModel({
    @required this.videos,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
        videos: List<Videos>.from(
      map["videos"]?.map((video) => Videos.fromMap(video)),
    ));
  }

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source));
}

class Videos {
  int id;
  String videoLink;
  String image;
  int duration;
  List<Pictures> videoPictures;
  Videos({
    @required this.videoLink,
    @required this.image,
    @required this.id,
    @required this.duration,
    @required this.videoPictures,
  });

  factory Videos.fromMap(Map<String, dynamic> map) {
    // print(map);
    return Videos(
      id: map["id"],
      image: map["image"],
      videoLink: map["video_files"][0]["link"],
      duration: map["duration"],
      // videoPictures: List<Pictures>.from(
      //   map["video_pictures"].map((pictures) => Pictures.fromMap(pictures)),
      // ),
      videoPictures: (map["video_pictures"] as List)
          .map((pictures) => Pictures.fromMap(pictures))
          .toList(),
    );
  }

  factory Videos.fromJson(String source) => Videos.fromMap(json.decode(source));
}

class Pictures {
  final String picture;

  Pictures({this.picture});

  factory Pictures.fromMap(Map<String, dynamic> map) {
    return Pictures(
      picture: map['picture'],
    );
  }

  factory Pictures.fromJson(String source) =>
      Pictures.fromMap(json.decode(source));
}
