import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/ui/movie_detail.dart';

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class CardScroll extends StatefulWidget {
  final List<Result> results;
  CardScroll({this.results});
  @override
  State<StatefulWidget> createState() => CardScrollState();
}

class CardScrollState extends State<CardScroll> {
  var padding = 20.0;
  var verticalInset = 20.0;
  var currentPageTrending;
  PageController controller;
  @override
  void initState() {
    super.initState();
    currentPageTrending = widget.results.length - 1;
    controller =
        PageController(initialPage: widget.results.length - 1, keepPage: false);
    controller.addListener(() {
      setState(() {
        currentPageTrending = controller.page;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          buildAspectRatio(),
          Positioned.fill(
            child: PageView.builder(
              itemCount: widget.results.length,
              controller: controller,
              reverse: true,
              itemBuilder: (context, index) {
                return Hero(
                  tag: '${widget.results[index].id}',
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieDetail(
                                  result: widget.results[index],
                                  heroTag: '${widget.results[index].id}',
                                )),
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  AspectRatio buildAspectRatio() {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(
        builder: (context, contraints) {
          var width = contraints.maxWidth;
          var height = contraints.maxHeight;

          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Widget> cardList = new List();

          for (var i = 0; i < widget.results.length; i++) {
            var delta = i - currentPageTrending;

            bool isOnRight = delta > 0;
            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);
            var cardItem = Positioned.directional(
              top: padding + verticalInset * max(-delta, 0.0),
              bottom: padding + verticalInset * max(-delta, 0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0)
                  ]),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: 'https://image.tmdb.org/t/p/w500/' +
                              '${widget.results[i].posterPath}',
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Text(
                                  '${widget.results[i].title}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 12, bottom: 12),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                        'Watch',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          '${widget.results[i].voteAverage}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellowAccent,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        },
      ),
    );
  }
}
