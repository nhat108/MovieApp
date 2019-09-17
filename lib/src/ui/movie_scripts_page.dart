import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/models/db.dart';
import 'package:nux_movie/src/models/screen_play_model.dart';
import 'package:nux_movie/src/ui/play_video_screen.dart';
import 'package:provider/provider.dart';

class MovieScript extends StatefulWidget {
  @override
  _MovieScriptState createState() => _MovieScriptState();
}

class _MovieScriptState extends State<MovieScript> {
  DatabaseService db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: StreamProvider<List<ScreenPlay>>.value(
        value: db.getStreamSripts(),
        child: CardScripts(),
      ),
    ));
  }
}

class CardScripts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scripts = Provider.of<List<ScreenPlay>>(context);
    return scripts != null&&scripts.length>0
        ? Container(
            padding: EdgeInsets.all(10),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 4 / 3.5,
              children: List.generate(scripts.length - 1, (i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PlayVideoScreen(path: scripts[i].url);
                    }));
                  },
                  child: _itemCard(scripts[i]),
                );
              }),
            ),
          )
        : CircularProgressIndicator();
  }

  _itemCard(ScreenPlay screenPlay) {
    return Card(
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                child: CachedNetworkImage(
                  imageUrl:screenPlay.thumnail==null?'':screenPlay.thumnail,
                  fit: BoxFit.cover,
                )),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 5, top: 2),
              child: Text(
                screenPlay.title,
                maxLines: 2,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            ))
          ],
        ),
      );
  }
}
