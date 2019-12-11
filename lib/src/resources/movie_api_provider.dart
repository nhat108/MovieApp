import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nux_movie/src/models/item_model.dart';

class MovideApiProvider {
  final _apiKey = '91bc96868c19a629d28a44b0a2786ae1';
  final _baseUrl = 'https://api.themoviedb.org/3';


  Future<Result>getMovieDetail(String id)async{
    final response=await http.get(_baseUrl+'/movie/$id?api_key=$_apiKey&language=en-US');
    if(response.statusCode==200){
      return Result.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to get movie detail id: $id');
    }
  }
  Future<ItemModel> fetchMovieDiscover(int page) async {
    final response = await http.get(_baseUrl +
        '/discover/movie?api_key=$_apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page');
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ItemModel> fetchMovieTreding() async {
    final response =
        await http.get(_baseUrl + '/trending/all/day?api_key=$_apiKey');
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ItemModel> fetchTopRated(int page) async {
    final response =
        await http.get('$_baseUrl/movie/top_rated?api_key=$_apiKey&language=en-US&page=1&page=$page');
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post top rated!');
    }
  }

  Future<ItemModel> fetchUpComming(int page) async {
    final response =
        await http.get(_baseUrl + '/movie/upcoming?api_key=$_apiKey&language=en-US&page=$page');
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post upcomming!');
    }
  }

  Future<Credits> fetchCast(int id) async {
    final response =
        await http.get(_baseUrl + '/movie/$id/credits?api_key=$_apiKey');
    if (response.statusCode == 200) {
      return Credits.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post Credits');
    }
  }

  Future<ItemModel> fetchRecommendations(int id) async {
    final response = await http.get(_baseUrl +
        '/movie/$id/recommendations?api_key=$_apiKey&language=en-US&page=1');
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post Recommendations');
    }
  }

  Future<ReviewList> fetchReviews(int id) async {
    final response = await http.get(
        _baseUrl + '/movie/$id/reviews?api_key=$_apiKey&language=en-US&page=1');
    if (response.statusCode == 200) {
      return ReviewList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post reviews');
    }
  }

  Future<Images> fetchImages(int id) async {
    final response = await http.get(_baseUrl +
        '/movie/$id/images?api_key=$_apiKey&language=en-US&include_image_language=null');
    if (response.statusCode == 200) {
      return Images.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load images');
    }
  }

  Future<Person> fetchPerson(int id) async {
    final response = await http
        .get(_baseUrl + '/person/$id?api_key=$_apiKey&language=en-US');
    if (response.statusCode == 200) {
      return Person.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load person');
    }
  }

  Future<ItemModel> fetchPersonMovies(int id) async {
    final response = await http.get(
        _baseUrl + '/person/$id/movie_credits?api_key=$_apiKey&language=en-US');
    if (response.statusCode == 200) {
      return ItemModel.fromJsonCast(json.decode(response.body));
    } else {
      throw Exception('Failed to load cast!');
    }
  }

  Future<ItemModel> searchMovie(String query, int page) async {
    final response = await http.get(_baseUrl +
        '/search/movie?api_key=$_apiKey&language=en-US&query=$query&page=1&include_adult=true');
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    }else{
      print(response.statusCode.toString());
      throw Exception('Failed to load search response');
    }
  }
  Future<MovieTrailer>fetchMovieTrailer(int id)async{
    final response=await http.get(_baseUrl+'/movie/$id/videos?api_key=$_apiKey&language=en-US');
    if(response.statusCode==200){
      return MovieTrailer.json(json.decode(response.body));
    }else{
      print('Error: '+response.statusCode.toString());
      throw Exception('Failed to load movie trailer');
    }
  }
}
