import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/models/item_model.dart';
import '../blocs/movies_bloc.dart';

class ReviewWidget extends StatefulWidget {
  final int id;
  ReviewWidget({this.id});
  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  @override
  void initState() {
    super.initState();
    bloc.fetchReviews(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: Color(0xFF2c3549),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: StreamBuilder(
        stream: bloc.reviews,
        builder: (context, AsyncSnapshot<ReviewList> snapshot) {
          if (snapshot.hasData)
            return _reviewList(snapshot.data.reviews);
          else if (snapshot.hasError)
            return Center(
              child: Icon(Icons.error),
            );
          else if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: Container(
                  width: 50, height: 50, child: CircularProgressIndicator()),
            );
          return Container();
        },
      ),
    );
  }

  _reviewList(List<Review> reviews) {
    if (reviews.length == 0) {
      return Center(
        child: Text(
          'No review yet!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 20,
              left: 15,
            ),
            width: 150,
            child: Text(
              'Reviews (${reviews.length - 1})',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
              child: ListView.builder(
                itemCount: reviews.length - 1,
                itemBuilder: (context, i) {
                  return Container(
                    margin: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Color(0xFF565f75),
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 45,
                          height: 45,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child:
                                Text('${reviews[i].author[0].toUpperCase()}'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${reviews[i].author}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFffe3d8),
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text('${reviews[i].content}',
                                  style: Theme.of(context).textTheme.subtitle),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    }
  }
}
