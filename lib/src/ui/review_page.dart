import 'package:flutter/material.dart';
import 'package:nux_movie/src/models/db.dart';
import 'package:nux_movie/src/models/item_video.dart';
import 'package:nux_movie/src/widgets/review_page_view.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key key}) : super(key: key);
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  DatabaseService db = DatabaseService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamProvider<List<Video>>.value(
        value: db.getStreamVideos(),
        child: ReviewPageView(
          onTap: playVideoDialog,
        ),
      ),
    );
  }

  playVideoDialog({String url, String thumnail}) {
    //TODO show dialog

  }
}
