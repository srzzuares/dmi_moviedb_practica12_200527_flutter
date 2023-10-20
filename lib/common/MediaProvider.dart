import 'dart:async';
import 'package:dmi_moviedb_practica12_200527_flutter/common/HttpHandler.dart';
import 'package:dmi_moviedb_practica12_200527_flutter/model/Media.dart';

abstract class MediaProvider {
  Future<List<Media>> fetchMedia(String category);
}

class MediaPrvider extends MediaProvider {
  HttpHandler _client = HttpHandler.get();
  @override
  Future<List<Media>> fetchMedia(String category) {
    return _client.fetchMovies(category: category);
  }
}

class ShowProvider extends MediaProvider {
  HttpHandler _client = HttpHandler.get();
  @override
  Future<List<Media>> fetchMedia(String category) {
    return _client.fetchShow(category: category);
  }
}
