import 'package:equatable/equatable.dart';

class Result {
  bool adult;
  String overview;
  String releaseDate;
  int id;
  String posterPath;
  String backdropPath;
  String originalTitle;
  String originalLanguage;
  String title;
  int voteCount;
  bool video;
  var voteAverage;
  List<int> genreIds;

  Result(
      {this.adult,
      this.overview,
      this.releaseDate,
      this.id,
      this.originalTitle,
      this.originalLanguage,
      this.title,
      this.voteCount,
      this.video,
      this.posterPath,
      this.backdropPath,
      this.voteAverage,
      this.genreIds});

  factory Result.fromJson(Map<String, dynamic> json) {
    List<int> list = List<int>();
    if (json['genre_ids'] != null) {
      var genres = json['genre_ids'] as List;
      genres.forEach((i) {
        list.add(i);
      });
    }

    return Result(
        voteCount: json['vote_count'],
        id: json['id'],
        video: json['video'],
        voteAverage: json['vote_average'],
        title: json['title'],
        posterPath: json['poster_path'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        backdropPath: json['backdrop_path'],
        adult: json['adult'],
        overview: json['overview'],
        releaseDate: json['release_date'],
        genreIds: list);
  }
}

class ItemModel extends Equatable {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<Result> results;
  final bool hasReachedMax;

  ItemModel(
      {this.hasReachedMax,
      this.page,
      this.totalResults,
      this.totalPages,
      this.results});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    var resultList = json['results'] as List;
    List<Result> discoverList =
        resultList.map((i) => Result.fromJson(i)).toList();
    return ItemModel(
      page: json['page'],
      totalPages: json['total_pages'],
      results: discoverList,
    );
  }
  factory ItemModel.fromJsonCast(Map<String, dynamic> json) {
    var list = json['cast'] as List;
    List<Result> results = list.map((i) => Result.fromJson(i)).toList();
    return ItemModel(results: results);
  }
  ItemModel copyWith(
      {List<Result> results,
      bool hasReachedMax,
      int page,
      int totalPages,
      int totalResults}) {
    return ItemModel(
        results: results ?? this.results,
        page: page ?? this.page,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }
}

class Cast {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;
  Cast(
      {this.castId,
      this.character,
      this.creditId,
      this.gender,
      this.id,
      this.name,
      this.order,
      this.profilePath});
  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      castId: json['cast_id'],
      character: json['character'],
      creditId: json['credit_id'],
      gender: json['gender'],
      id: json['id'],
      name: json['name'],
      order: json['order'],
      profilePath: json['profile_path'],
    );
  }
}

class Credits {
  int id;
  List<Cast> cast;
  List<Object> crew;
  Credits({this.id, this.cast, this.crew});
  factory Credits.fromJson(Map<String, dynamic> json) {
    var casts = json['cast'] as List;
    List<Cast> castList = casts.map((i) => Cast.fromJson(i)).toList();
    return Credits(id: json['id'], cast: castList, crew: json['crew']);
  }
}

class ReviewList {
  int id;
  int page;
  List<Review> reviews;
  int totalPages;
  int totalResults;
  ReviewList(
      {this.id, this.page, this.reviews, this.totalPages, this.totalResults});

  factory ReviewList.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Review> reviewList = list.map((i) => Review.fromJson(i)).toList();
    return ReviewList(
        id: json['id'],
        page: json['page'],
        reviews: reviewList,
        totalPages: json['total_pages'],
        totalResults: json['total_results']);
  }
}

class Review {
  String author;
  String content;
  String id;
  String url;

  Review({this.author, this.content, this.id, this.url});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        author: json['author'],
        content: json['content'],
        id: json['id'],
        url: json['url']);
  }
}

class Poster {
  var aspectRatio;
  String filePath;
  int height;
  var iso6391;
  var voteAverage;
  int voteCount;
  int width;
  Poster(
      {this.aspectRatio,
      this.filePath,
      this.height,
      this.width,
      this.voteCount,
      this.voteAverage,
      this.iso6391});

  factory Poster.fromJson(Map<String, dynamic> json) {
    return Poster(
      aspectRatio: json['aspect_ratio'],
      filePath: json['file_path'],
      height: json['height'],
      iso6391: json['iso_639_1'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      width: json['width'],
    );
  }
}

class Images {
  int id;
  List<Poster> posters;
  List<Poster> backdrops;
  Images({this.id, this.backdrops, this.posters});

  factory Images.fromJson(Map<String, dynamic> json) {
    var a = json['posters'] as List;
    var b = json['backdrops'] as List;
    List<Poster> posters = a.map((i) => Poster.fromJson(i)).toList();
    List<Poster> backdrops = b.map((i) => Poster.fromJson(i)).toList();
    return Images(id: json['id'], posters: posters, backdrops: backdrops);
  }
}

class Person {
  String birthday;
  String knownForDepartment;
  var deathday;
  String name;
  int id;
  List<String> alsoKnownAs;
  int gender;
  String biography;
  var popularity;
  String placeOfBirth;
  String profilePath;
  bool adult;
  String imdbId;
  var homepage;

  Person(
      {this.id,
      this.adult,
      this.alsoKnownAs,
      this.biography,
      this.birthday,
      this.deathday,
      this.gender,
      this.name,
      this.homepage,
      this.imdbId,
      this.knownForDepartment,
      this.placeOfBirth,
      this.popularity,
      this.profilePath});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        birthday: json['birthday'],
        knownForDepartment: json['known_for_department'],
        deathday: json['deathday'],
        id: json['id'],
        name: json['name'],
        gender: json['gender'],
        biography: json['biography'],
        popularity: json['popularity'],
        placeOfBirth: json['place_of_birth'],
        profilePath: json['profile_path'],
        adult: json['adult'],
        imdbId: json['imdb_id']);
  }
}

class MovieTrailer {
  int id;
  List<Trailer> trailers;
  MovieTrailer({this.id, this.trailers});

  factory MovieTrailer.json(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Trailer> trailers = list.map((i) => Trailer.fromJson(i)).toList();
    return MovieTrailer(id: json['id'], trailers: trailers);
  }
}

class Trailer {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;
  Trailer(
      {this.id,
      this.iso31661,
      this.iso6391,
      this.key,
      this.name,
      this.site,
      this.size,
      this.type});

  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(
        key: json['key'],
        name: json['name'],
        site: json['youtube'],
        type: json['type'],
        id: json['id']);
  }
}
