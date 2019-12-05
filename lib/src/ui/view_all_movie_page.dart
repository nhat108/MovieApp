import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nux_movie/src/blocs/movie_bloc.dart';
import 'package:nux_movie/src/blocs/movie_event.dart';
import 'package:nux_movie/src/blocs/movie_state.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:nux_movie/src/widgets/waiting_widget.dart';

class ViewAllMovie extends StatefulWidget {
  @override
  _ViewAllMovieState createState() => _ViewAllMovieState();
}

class _ViewAllMovieState extends State<ViewAllMovie> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  final MovieBloc _movieBloc = MovieBloc(httpClient: http.Client());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _movieBloc.dispatch(Fetch());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _movieBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder(
      bloc: _movieBloc,
      builder: (context, state) {
        if (state is MovieUninitialized) {
          return WaitingWidget();
        }
        if (state is MovieLoaded) {
          print('state:' +state.results.length.toString());
          return ListView.builder(
            itemBuilder: (context, index) {
              return index >= state.results.length
                  ? _bottomLoader()
                  : _item(state.results[index]);
            },
            itemCount: state.hasReachedMax
                ? state.results.length
                : state.results.length + 1,
            controller: _scrollController,
          );
        }
        return Container();
      },
    ));
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _movieBloc.dispatch(Fetch());
    }
  }

  _bottomLoader() {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: Center(
          child: SizedBox(
            width: 33,
            height: 33,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  _item(Result result) {
    return Container(
      key: Key('{$result.id}'),
      width: 120,
      height: 200,
      margin: EdgeInsets.all(7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w185/${result.posterPath}',
                width: 120,
                height: 170,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${result.title}',
              maxLines: 2,
              style: TextStyle(
                  color: Color(0xFFff877c),
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Expanded(
            flex: 1,
            child: Text(
              Utils.getGenresList(result.genreIds),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFffe3d8),
                  fontSize: 12),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 20,
                ),
                SizedBox(
                  width: 3,
                ),
                Text('${result.voteAverage}')
              ],
            ),
          )
        ],
      ),
    );
  }
}
