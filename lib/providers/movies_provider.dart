
import 'package:app_movies/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {

  final String _apiKey = '78df4f5a15c6379d72d64c57b9ec146d';
  final String _baseURL = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movies> onDisplayMovies = [];
  List<Movies> popularMovies = [];

  MoviesProvider() {
    print('MoviesProvider inicializado');

    getOnDisplayMovies();
    getPopularMovies();
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

  getPopularMovies() async {
    var url = Uri.https(_baseURL, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1'
    });

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromjson(response.body);
  
    popularMovies = [ ...popularMovies, ...popularResponse.results];
    notifyListeners();
  }
}