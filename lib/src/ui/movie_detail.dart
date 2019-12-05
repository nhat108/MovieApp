import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/ui/play_video_screen.dart';
import 'package:nux_movie/src/utils/error.dart';
import 'package:nux_movie/src/utils/utils.dart';
import 'package:nux_movie/src/widgets/cast_list.dart';
import 'package:nux_movie/src/widgets/image_widget.dart';
import 'package:nux_movie/src/widgets/recommendations_list.dart';
import 'package:nux_movie/src/widgets/reviews.dart';
import 'package:nux_movie/src/widgets/waiting_widget.dart';
import '../blocs/movies_bloc.dart';
import '../utils/colors.dart';

class MovieDetail extends StatefulWidget {
  final Result result;
  final String heroTag;
  MovieDetail({@required this.result, this.heroTag, Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  void initState() {
    super.initState();
    bloc.fetchCasts(widget.result.id);
    bloc.fetchRecommend(widget.result.id);
    bloc.fetchTrailerMovie(widget.result.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(MovieColor.kPrimaryDarkColor),
        child: Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }

  _getBackground() {
    return Container(
      child: CachedNetworkImage(
        imageUrl:
            'https://image.tmdb.org/t/p/original/${widget.result.backdropPath}',
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(),
        errorWidget: (context, url, error) => ErrorUtils.getErrorBackDrop(),
      ),
      constraints: BoxConstraints.expand(height: 300),
    );
  }

  _getGradient() {
    return Container(
      margin: EdgeInsets.only(top: 190),
      height: 110,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Color(0x00736AB7), Color(0xFF050d20)],
              stops: [0.0, 0.9],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(0.0, 1.0))),
    );
  }

  _getToolbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
          )
        ],
      ),
    );
  }

  _getContent() {
    return ListView(
      padding: EdgeInsets.fromLTRB(0, 72, 0, 32),
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(16.0, 100.0, 16.0, 2),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15.0),
                    margin: EdgeInsets.only(top: 25.0),
                    decoration: BoxDecoration(
                        color: Color(MovieColor.kPrimaryColor),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 100.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${widget.result.title}',
                                style: Theme.of(context).textTheme.title,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                Utils.getGenresList(widget.result.genreIds),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('${widget.result.voteAverage}'),
                                        _buildTrailerButton(),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Hero(
                      tag: widget.heroTag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w185/${widget.result.posterPath}',
                            width: 88,
                            height: 120,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => null,
                            errorWidget: (context, url, error) => Container(
                                  width: 88,
                                  height: 120,
                                  child: ErrorUtils.getErrorPoster(),
                                )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
          decoration: BoxDecoration(
              color: Color(MovieColor.kPrimaryColor),
              borderRadius: BorderRadius.circular(5.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Story Line',
                style: TextStyle(
                    fontSize: 20, color: Color(MovieColor.kTextColor)),
              ),
              SizedBox(
                height: 8,
              ),
              Text('${widget.result.overview}',
                  style: Theme.of(context).textTheme.subtitle),
              SizedBox(
                height: 10,
              ),
              Text(
                'Cast',
                style: TextStyle(
                    fontSize: 20, color: Color(MovieColor.kTextColor)),
              ),
              StreamBuilder(
                stream: bloc.casts,
                builder: (context, AsyncSnapshot<Credits> snapshot) {
                  if (snapshot.hasData)
                    return CastList(
                      casts: snapshot.data.cast,
                    );
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return WaitingWidget();
                  return Container();
                },
              ),
              Text(
                'Recommendations',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(MovieColor.kTextColor),
                ),
              ),
              StreamBuilder(
                stream: bloc.recommend,
                builder: (context, AsyncSnapshot<ItemModel> snapshot) {
                  if (snapshot.hasData) {
                    return RecommendationsList(
                      results: snapshot.data.results,
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return WaitingWidget();
                  return Container();
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Color(0xFF565f75),
                        borderRadius: BorderRadius.circular(10.0)),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200,
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return ReviewWidget(id: widget.result.id);
                              });
                        },
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Reviews',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.mode_comment),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Color(0xFF565f75),
                        borderRadius: BorderRadius.circular(10.0)),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 200,
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              elevation: 10,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return ImagesMovie(id: widget.result.id);
                              });
                        },
                        iconSize: 30,
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Photos',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.image),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildTrailerButton() => StreamBuilder<MovieTrailer>(
        stream: bloc.movieTrailer,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Trailer> trailers = snapshot.data.trailers;
            if (trailers.length > 0)
              return trailers.length == 1
                  ? Container(
                      width: 80,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.red[400],
                          borderRadius: BorderRadius.circular(8)),
                      child: IconButton(
                        onPressed: () {
                          _navigatePlayVideoScreen(path: trailers[0].key);
                        },
                        color: Colors.blue,
                        icon: Text('Video'),
                      ),
                    )
                  : _listItemTrailer(trailers);
          }
          return Container();
        },
      );
  _listItemTrailer(List<Trailer> trailers) {
    var items = List<PopupMenuItem>();
    for (int i = 0; i < trailers.length; i++) {
      items.add(PopupMenuItem(
          value: i,
          child: Text(
            trailers[i].name,
            maxLines: 1,
            style: TextStyle(fontSize: 15),
          )));
    }
    return PopupMenuButton(
      child: Container(
        width: 80,
        height: 35,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            color: Colors.red[400], borderRadius: BorderRadius.circular(8)),
        child: Text('Videos'),
      ),
      itemBuilder: (context) => items,
      initialValue: 0,
      onSelected: (value) {
        String path = trailers[value].key;
        _navigatePlayVideoScreen(path: path);
      },
    );
  }

  _navigatePlayVideoScreen({String path}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PlayVideoScreen(path: path);
    }));
  }
}
