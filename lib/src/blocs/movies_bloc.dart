import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/services/tmdb_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

final bloc = MoviesBloc();

class MoviesBloc {
  final _repository = Repository();
  final _moiveDetail=PublishSubject<Result>();
  final _moviesTrending = PublishSubject<ItemModel>();
  final _moviesDiscover = PublishSubject<ItemModel>();
  final _moviesTopRated = PublishSubject<ItemModel>();
  final _moviesUpComming = PublishSubject<ItemModel>();
  final _moviesCasts = PublishSubject<Credits>();
  final _movieRecommend = PublishSubject<ItemModel>();
  final _movieReviews = PublishSubject<ReviewList>();
  final _movieImages = PublishSubject<Images>();
  final _person = PublishSubject<Person>();
  final _personMovies = PublishSubject<ItemModel>();
  final _searchMovie = PublishSubject<ItemModel>();
  final _movieTrailer = PublishSubject<MovieTrailer>();

  Observable<Result> get detail=> _moiveDetail.stream;
  Observable<ItemModel> get trending => _moviesTrending.stream;
  Observable<ItemModel> get discover => _moviesDiscover.stream;
  Observable<ItemModel> get topRated => _moviesTopRated.stream;
  Observable<ItemModel> get upComming => _moviesUpComming.stream;
  Observable<Credits> get casts => _moviesCasts.stream;
  Observable<ItemModel> get recommend => _movieRecommend.stream;
  Observable<ReviewList> get reviews => _movieReviews.stream;
  Observable<Images> get images => _movieImages.stream;
  Observable<Person> get person => _person.stream;
  Observable<ItemModel> get personMovies => _personMovies.stream;
  Observable<ItemModel> get searchMovie => _searchMovie.stream;
  Observable<MovieTrailer> get movieTrailer => _movieTrailer.stream;

  Future<Result> fetchMovieDetail(String id)async{
    return _repository.getMovieDetail(id);
    // _repository.getMovieDetail(id).then((onValue){
    //   _moiveDetail.sink.add(onValue);
      
    // }).catchError((error){
    //   _moiveDetail.addError(error);
    //   throw Exception(error.toString());
    // });
   
  }
  fetchTrendingMovies() async {
    if (!_moviesTrending.isClosed) {
      _repository.fetchTrendingMovies().then((onValue) {
        ItemModel itemModel = onValue;
        _moviesTrending.sink.add(itemModel);
      }).catchError((onError) {
        _moviesTrending.addError(onError);
        throw Exception(onError.toString());
      });
    }
  }

  fetchDiscoverMovies(int page) async {
    if (!_moviesDiscover.isClosed) {
      _repository.fetchDiscoverMovies(page).then((onValue) {
        ItemModel itemModel = onValue;
        _moviesDiscover.sink.add(itemModel);
      }).catchError((onError) {
        _moviesDiscover.addError(onError);
        throw Exception(onError.toString());
      });
    }
  }

  fetchTopRatedMovie(int page) async {
    if (!_moviesTopRated.isClosed) {
      _repository.fetchTopRated(page).then((onValue) {
        ItemModel itemModel = onValue;
        _moviesTopRated.sink.add(itemModel);
      }).catchError((onError) {
        _moviesTopRated.addError(onError);
        throw Exception(onError.toString());
      });
    }
  }

  fetchUpCommingMovie(int page) async {
    if (!_moviesUpComming.isClosed) {
      _repository.fetchUpComing(page).then((onValue) {
        ItemModel itemModel = onValue;
        _moviesUpComming.sink.add(itemModel);
      }).catchError((onError) {
        _moviesUpComming.addError(onError);
        throw Exception(onError.toString());
      });
    }
  }

  fetchCasts(int id) async {
    if (!_moviesCasts.isClosed) {
      _repository.fetchCast(id).then((onValue) {
        Credits credits = onValue;
        _moviesCasts.sink.add(credits);
      }).catchError((onError) {
        _moviesCasts.addError(onError);
        throw Exception(onError.toString());
      });
    }
  }

  fetchRecommend(int id) async {
    if (!_movieRecommend.isClosed) {
      _repository.fetchRecommend(id).then((onValue) {
        ItemModel itemModel = onValue;
        _movieRecommend.sink.add(itemModel);
      }).catchError((onError) {
        _movieRecommend.addError(onError.toString());
        throw Exception(onError.toString());
      });
    }
  }

  fetchReviews(int id) async {
    if (!_movieReviews.isClosed) {
      _repository.fetchReviews(id).then((onValue) {
        ReviewList reviewList = onValue;
        _movieReviews.sink.add(reviewList);
      }).catchError((onError) {
        _movieReviews.addError(onError);
        throw Exception(onError.toString());
      });
    }
  }

  fetchImages(int id) async {
    if (!_movieImages.isClosed) {
      _repository.fetchImages(id).then((onValue) {
        Images images = onValue;
        _movieImages.sink.add(images);
      }).catchError((onError) {
        _movieImages.addError(onError);
        throw Exception(onError.toString());
      });
    }
  }

  fetchPerson(int id) async {
    if (!_person.isClosed) {
      _repository.fetchPerson(id).then((onValue) {
        Person person = onValue;
        _person.sink.add(person);
      }).catchError((onError) {
        _person.addError(onError);
        throw Exception(onError.toString());
      });
    }
  }

  fetchPersonMovies(int id) async {
    if (!_personMovies.isClosed) {
      _repository.fetchPersonMovies(id).then((onValue) {
        ItemModel itemModel = onValue;
        _personMovies.sink.add(itemModel);
      }).catchError((onError) {
        _personMovies.addError(onError);
        throw Exception(onError.toString());
      });
    }
  }

  fetchSearchMovie(String query, int page) {
    if (!_searchMovie.isClosed) {
      _repository.searchMovie(query, page).then((onValue) {
        ItemModel itemModel = onValue;
        _searchMovie.sink.add(itemModel);
      }).catchError((onError) {
        _searchMovie.addError(onError);
        throw Exception(onError.toString());
      });
    }
  }

  fetchTrailerMovie(int id) {
    if (!_movieTrailer.isClosed) {
      _repository.fetchtrailer(id).then((onValue) {
        MovieTrailer trailer = onValue;
        _movieTrailer.sink.add(trailer);
      }).catchError((onError) {
        _movieTrailer.addError(onError);
        throw Exception(onError.toString());
      });
    }
  }

  void disposeAll() {
    _moiveDetail.close();
    _moviesTrending.close();
    _moviesDiscover.close();
    _moviesTopRated.close();
    _moviesUpComming.close();
    _moviesCasts.close();
    _movieReviews.close();
    _movieRecommend.close();
    _movieImages.close();
    _movieImages.close();
    _person.close();
    _personMovies.close();
    _searchMovie.close();
  }

  void disposeTrendingBloc() {
    _moviesTrending.close();
  }

  void disposeDiscoverBloc() {
    _moviesDiscover.close();
  }

  void disposeTopRatedBloc() {
    _moviesTopRated.close();
  }

  void disposeUpCommingBloc() {
    _moviesUpComming.close();
  }

  void disposeCastsBloc() {
    _moviesCasts.close();
  }

  void disposeReviewsBloc() {
    _movieReviews.close();
  }

  void disposeRecommendBloc() {
    _movieRecommend.close();
  }

  void disposeImagesBloc() {
    _movieImages.close();
  }

  void disposePersonBloc() {
    _person.close();
  }

  void disposePersonMoviesBloc() {
    _personMovies.close();
  }

  void diposeSearchMovieBloc() {
    _searchMovie.close();
  }
}
