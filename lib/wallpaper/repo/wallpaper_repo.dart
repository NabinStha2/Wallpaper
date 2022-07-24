import 'dart:io';
import "package:http/http.dart" as http;
import 'package:wallpaper/wallpaper/api_keys.dart';
import 'package:wallpaper/wallpaper/models/wallpaper_model.dart';

class WallpaperRepo {
  final baseUrl = "api.pexels.com";

  Future<WallpaperResponse> getWallpaper({int page}) async {
    try {
      final queryParameters = {
        "page": "$page",
        "per_page": "40",
      };
      final uri = Uri.https(baseUrl, "/v1/curated", queryParameters);
      final response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: API_KEY,
        HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      });
      // print(response.body);
      return WallpaperResponse.fromJson(response.body);
    } catch (err) {
      return err;
    }
  }

  Future<WallpaperResponse> getSearchWallpaper(
      {String searchQuery, int page}) async {
    try {
      // print("repo: $searchQuery");
      final queryParameters = {
        "query": searchQuery,
        "page": "$page",
        "per_page": "40",
      };
      final uri = Uri.https(baseUrl, "/v1/search", queryParameters);
      final response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: API_KEY,
        HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      });
      // print(response.body);
      return WallpaperResponse.fromJson(response.body);
    } catch (err) {
      print(err);
      return err;
    }
  }
}
