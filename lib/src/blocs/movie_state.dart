import 'package:equatable/equatable.dart';
import 'package:nux_movie/src/models/item_model.dart';

abstract class MovieState extends Equatable {
  MovieState([List props = const []]) : super(props);
}

class MovieUninitialized extends MovieState {
  @override
  String toString() {
    return 'MovieUninitialized';
  }
}

class MovieError extends MovieState {
  @override
  String toString() {
    return 'MovieError';
  }
}

class MovieLoaded extends MovieState {
  final ItemModel itemModel;
  final bool hasReachedMax;
  final List<Result>results;
  MovieLoaded({this.results, this.itemModel, this.hasReachedMax})
      : super([results,itemModel, hasReachedMax]);
  MovieLoaded copyWith({ItemModel itemModel, bool hasReachedMax}) {

    return MovieLoaded(
        results: itemModel.results??this.results,
        itemModel: itemModel ?? this.itemModel,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() {
    return 'MovieLoaded {itemModel: ${itemModel.results.length},hasReachedMax :$hasReachedMax}';
  }
}
