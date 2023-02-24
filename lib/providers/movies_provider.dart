
import 'package:app_movies/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {

  final String _apiKey = '78df4f5a15c6379d72d64c57b9ec146d';
  final String _baseURL = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movies> onDisplayMovies = [];
  List<Movies> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider() {
    print('MoviesProvider inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseURL, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
  
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage ++;
    
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromjson(jsonData);
  
    popularMovies = [ ...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMoviesCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;
    notifyListeners();
    return creditsResponse.cast;
  }
}