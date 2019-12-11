import 'package:flutter/material.dart';
import 'package:nux_movie/src/models/db.dart';
import 'package:nux_movie/src/models/movie_lines.dart';
import 'package:provider/provider.dart';

class LinePage extends StatefulWidget {
  @override
  _LinePageState createState() => _LinePageState();
}

class _LinePageState extends State<LinePage> {
  DatabaseService db = DatabaseService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20, right: 10, left: 10),
        child: StreamProvider<List<Line>>.value(
          value: db.getStreamLines(),
          child: CardList(),
        ),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lines = Provider.of<List<Line>>(context);
    return lines != null
        ? Container(
            child: ListView.builder(
              itemCount: lines.length,
              itemBuilder: (context, i) => _item(lines[i], context),
            ),
          )
        : Center(child:CircularProgressIndicator());
  }

  _item(Line line, context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Stack(
        children: <Widget>[
          Image.network(
            line.imageUrl,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            top: 2,
            left: 3,
            child: Text(line.title,maxLines: 2,))
        ],
      ),
    );
  }
}
