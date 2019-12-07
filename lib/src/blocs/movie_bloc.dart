import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nux_movie/src/blocs/movie_event.dart';
import 'package:nux_movie/src/blocs/movie_state.dart';
import 'package:nux_movie/src/contants/enums.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/resources/respository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final http.Client httpClient;
  Repository _repository = Repository();
  final TypeOfMovie type;
  MovieBloc({@required this.httpClient,@required this.type});

  @override
  Stream<MovieState> transformEvents(
    Stream<MovieEvent> events,
    Stream<MovieState> Function(MovieEvent event) next,
  ) {
    return super.transformEvents(
      (events as Observable<MovieEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  MovieState get initialState => MovieUninitialized();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is MovieUninitialized) {
          final ItemModel itemModel = await _fetchMovies(1);
          yield MovieLoaded(results: itemModel.results,itemModel: itemModel, hasReachedMax: false);
          return;
        }
        if (currentState is MovieLoaded) {
          final ItemModel itemModel = await _fetchMovies(
              (currentState as MovieLoaded).itemModel.page + 1);
          yield itemModel.totalPages == itemModel.page
              ? (currentState as MovieLoaded).copyWith(hasReachedMax: true)
              : MovieLoaded(
                  results:
                      (currentState as MovieLoaded).results + itemModel.results,
                  itemModel: itemModel,
                  hasReachedMax: false);
        }
      } catch (_) {
        yield MovieError();
      }
    }
  }

  bool _hasReachedMax(MovieState state) =>
      state is MovieLoaded && state.hasReachedMax;

  Future<ItemModel> _fetchMovies(int page) async {
    ItemModel itemModel;
    print('type: '+type.toString());
    switch(type){
      case TypeOfMovie.DISCOVER:
        itemModel=await _repository.fetchDiscoverMovies(page);
        break;
      case TypeOfMovie.TOPRATED:
        itemModel= await _repository.fetchTopRated(page);
        break;
      case TypeOfMovie.UPCOMING:
       itemModel=await _repository.fetchUpComming(page);
        break;
    }
    return itemModel;
  }
}
