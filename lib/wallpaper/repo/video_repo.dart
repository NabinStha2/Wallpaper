import 'dart:io';
import "package:http/http.dart" as http;
import 'package:wallpaper/wallpaper/api_keys.dart';
import 'package:wallpaper/wallpaper/models/video_model.dart';

class VideoRepo {
  final baseUrl = "api.pexels.com";

  Future<VideoModel> getVideo({int page}) async {
    try {
      final queryParameters = {
        "page": "$page",
        "per_page": "40",
      };

      final uri = Uri.https(baseUrl, "/videos/popular", queryParameters);
      final response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: API_KEY,
        HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      });

      // print(response.body);
      return VideoModel.fromJson(response.body);
    } catch (e) {
      return e;
    }
  }

  Future<VideoModel> getSearchVideos({String searchQuery, int page}) async {
    try {
      print("repo: $searchQuery");
      final queryParameters = {
        "query": searchQuery,
        "page": "$page",
        "per_page": "40",
      };
      final uri = Uri.https(baseUrl, "/videos/search", queryParameters);
      final response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: API_KEY,
        HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      });
      // print(response.body);
      return VideoModel.fromJson(response.body);
    } catch (err) {
      print(err);
      return err;
    }
  }
}
