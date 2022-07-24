import 'dart:convert';

import 'package:flutter/material.dart';

class WallpaperModel {
  int photographerId;
  String photographerUrl;
  String photographer;
  SrcModel src;

  WallpaperModel({
    @required this.photographerId,
    @required this.photographerUrl,
    @required this.photographer,
    @required this.src,
  });

  factory WallpaperModel.fromMap(Map<String, dynamic> json) {
    return WallpaperModel(
      photographer: json["photographer"],
      photographerId: json["photographer_id"],
      photographerUrl: json["photographer_url"],
      src: SrcModel.fromMap(json["src"]),
    );
  }

  factory WallpaperModel.fromJson(String source) {
    return WallpaperModel.fromMap(jsonDecode(source));
  }
}

class WallpaperResponse {
  final List<WallpaperModel> wallpaperModel;

  WallpaperResponse({this.wallpaperModel});

  // Map<String, dynamic> toMap() {
  //   return {
  //     'WallpaperModel': WallpaperModel?.map((x) => x.toMap())?.toList(),
  //   };
  // }

  factory WallpaperResponse.fromMap(Map<String, dynamic> map) {
    return WallpaperResponse(
      wallpaperModel: List<WallpaperModel>.from(
        map['photos']?.map((photo) => WallpaperModel.fromMap(photo)),
      ),
    );
  }

  // String toJson() => json.encode(toMap());

  factory WallpaperResponse.fromJson(String source) =>
      WallpaperResponse.fromMap(json.decode(source));
}

class SrcModel {
  String original;
  String small;
  String portrait;

  SrcModel({
    @required this.original,
    @required this.small,
    @required this.portrait,
  });

  factory SrcModel.fromMap(Map<String, dynamic> json) {
    return SrcModel(
      original: json["original"],
      small: json["small"],
      portrait: json["portrait"],
    );
  }

  factory SrcModel.fromJson(String source) {
    return SrcModel.fromMap(jsonDecode(source));
  }
}
