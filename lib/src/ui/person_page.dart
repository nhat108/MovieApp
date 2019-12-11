import 'dart:ui' as prefix0;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nux_movie/src/contants/colors.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/utils/error.dart';
import 'package:nux_movie/src/utils/utils.dart';
import 'package:nux_movie/src/widgets/biography_card.dart';
import 'package:nux_movie/src/widgets/recommendations_list.dart';
import 'package:nux_movie/src/widgets/waiting_widget.dart';
import '../blocs/movies_bloc.dart';

class PersonPage extends StatefulWidget {
  final int id;
  final String profilePath;
  PersonPage({this.id, this.profilePath});
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  void initState() {
    super.initState();
    bloc.fetchPerson(widget.id);
    bloc.fetchPersonMovies(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(kPrimaryColor),
        child: Stack(
          children: <Widget>[
            _getBackground(profilePath: widget.profilePath),
            _getContent(),
            _getToolbar(),
          ],
        ),
      ),
    );
  }

  _getBackground({String profilePath = ''}) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            child: CachedNetworkImage(
              imageUrl: 'http://image.tmdb.org/t/p/original$profilePath',
              width: width,
              height: height,
              errorWidget: (context, url, error) => Container(
                width: width,
                height: height,
                child: ErrorUtils.getErrorBackgroundPerson(),
              ),
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: prefix0.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          )
        ],
      ),
    );
  }

  _getToolbar() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
    );
  }

  _getContent() {
    var width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: bloc.person,
      builder: (context, AsyncSnapshot<Person> snapshot) {
        if (snapshot.hasData) {
          Person person = snapshot.data;
          String sexPath = person.gender == 1
              ? 'assets/svg/female.svg'
              : 'assets/svg/male.svg';
          return ListView(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 32),
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(16, 50, 16, 2),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          width: width,
                          padding: EdgeInsets.all(15.0),
                          margin: EdgeInsets.only(top: 80),
                          decoration: BoxDecoration(
                              color: Color(kPrimaryColor),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 60),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${person.name}',
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${person.placeOfBirth??''}',
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.subhead,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                height: 2.0,
                                width: 18.0,
                                color: new Color(0xff00c6ff),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                      '${Utils.getAge(person.birthday) == 0 ? '' : Utils.getAge(person.birthday)}'),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    child: SvgPicture.asset(sexPath),
                                  ),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Text('${person.knownForDepartment}')
                                ],
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 135,
                            height: 135,
                            margin: EdgeInsets.all(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    'http://image.tmdb.org/t/p/original${person.profilePath}',
                                errorWidget: (context, url, error) =>
                                    ErrorUtils.getErrorPersonAvatar(),
                              ),
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
                  color: Color(kPrimaryColor),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Biography',
                      style: TextStyle(fontSize: 20, color: Color(kTextColor)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    BiographyCard(
                      biography: person.biography,
                      personName: person.name,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Know For',
                      style: TextStyle(fontSize: 20, color: Color(kTextColor)),
                    ),
                    StreamBuilder(
                      stream: bloc.personMovies,
                      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
                        if (snapshot.hasData) {
                          List<Result> results = snapshot.data.results;
                          if (results.length > 0)
                            return RecommendationsList(
                              results: results,
                            );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Icon(Icons.error),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: WaitingWidget());
                        }
                        return Container();
                      },
                    )
                  ],
                ),
              )
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Icon(Icons.error),
          );
        }
        return Container();
      },
    );
  }
}
