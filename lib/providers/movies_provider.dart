
import 'package:app_movies/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {

  String _apiKey = '78df4f5a15c6379d72d64c57b9ec146d';
  String _baseURL = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movies> onDisplayMovies = [];

  MoviesProvider() {
    print('MoviesProvider inicializado');

    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseURL, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1'
    });

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
  
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }
}