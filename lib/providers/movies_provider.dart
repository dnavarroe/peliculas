
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/search_movies_response.dart';


class MoviesProvider extends ChangeNotifier{

  final String _apiKey    = '670d29c315bbce12a49414fbfef6dd8d';
  final String _baseurl   = 'api.themoviedb.org';
  final String _lenguage  = 'en-US';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int,List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider(){
    print('MoviesProvider inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page =1]) async {
    final url = Uri.https(_baseurl, endpoint, {
      'api_key' :_apiKey,
      'language':_lenguage,
      'page'    : '$page'
      
      });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async{
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async{

    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular',_popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    
    popularMovies = [ ...popularMovies, ...popularResponse.results ];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async{

  if(moviesCast.containsKey(movieId))return moviesCast[movieId]!;

  final jsonData = await _getJsonData('3/movie/$movieId/credits');
  final creditsResponse = CreditsResponse.fromJson(jsonData);

  moviesCast[movieId] = creditsResponse.cast;

  return creditsResponse.cast;

  }

  Future<List<Movie>> searchMovies(String query) async{

  final url = Uri.https(_baseurl, '3/search/movie', {
    'api_key' :_apiKey,
    'language':_lenguage,
    'query': query
      
  });

  final response = await http.get(url);
  final searchResponse = SearchResponse.fromJson(response.body);

  return searchResponse.results;

  }

}