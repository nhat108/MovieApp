import 'package:nux_movie/src/models/item_model.dart';
import 'movie_api_provider.dart';

class Repository{
  final moviesApiProvider=MovideApiProvider();
  Future<Result>getMovieDetail(String id)=>moviesApiProvider.getMovieDetail(id);
  Future<ItemModel> fetchTrendingMovies()=>moviesApiProvider.fetchMovieTreding();
  Future<ItemModel>fetchDiscoverMovies(int page)=>moviesApiProvider.fetchMovieDiscover(page);
  Future<ItemModel>fetchTopRated(int page)=>moviesApiProvider.fetchTopRated(page);
  Future<ItemModel>fetchUpComming(int page)=>moviesApiProvider.fetchUpComming(page);
  Future<Credits>fetchCast(int id)=>moviesApiProvider.fetchCast(id);
  Future<ItemModel>fetchRecommend(int id)=>moviesApiProvider.fetchRecommendations(id);
  Future<ReviewList>fetchReviews(int id)=>moviesApiProvider.fetchReviews(id);
  Future<Images>fetchImages(int id)=>moviesApiProvider.fetchImages(id);
  Future<Person>fetchPerson(int id)=>moviesApiProvider.fetchPerson(id);
  Future<ItemModel>fetchPersonMovies(int id)=>moviesApiProvider.fetchPersonMovies(id);
  Future<ItemModel>searchMovie(String query,int page)=>moviesApiProvider.searchMovie(query, page);
  Future<MovieTrailer>fetchtrailer(int id)=>moviesApiProvider.fetchMovieTrailer(id);
}