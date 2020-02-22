import 'package:flutter/material.dart';
import 'package:nux_movie/src/constants/colors.dart';
import 'package:nux_movie/src/ui/line_page.dart';
import 'package:nux_movie/src/ui/movie_scripts_page.dart';
import 'package:nux_movie/src/ui/watch_movie_list.dart';

class FunPage extends StatefulWidget {
  const FunPage({Key key}) : super(key: key);

  @override
  _FunPageState createState() => _FunPageState();
}

enum FunTypes { WATCH_MOVIES, MOVIE_LINES, MOVIE_QUOTES, MOVIE_SCRIPTS }

class _FunPageState extends State<FunPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kPrimaryColor),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _item(
                    type: FunTypes.MOVIE_LINES,
                    title: 'Movie Lines',
                    image: 'assets/images/joker.jpg'),
                SizedBox(
                  height: 20,
                ),
                _item(
                    type: FunTypes.MOVIE_SCRIPTS,
                    title: 'Movie Scripts',
                    image: 'assets/images/script.png'),
                _item(
                    type: FunTypes.WATCH_MOVIES,
                    title: 'Watch Movies',
                    image: 'assets/images/joker.jpg')
              ],
            ),
          ),
        ),
      ),
    );
  }

  _item({String title, String image, Color color, FunTypes type}) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        _navigatePage(type);
      },
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                fit: BoxFit.fitWidth,
                width: width * 0.8,
                height: height * 0.4,
              ),
            ),
            Positioned.fill(
              bottom: 20,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Aller',
                      fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _navigatePage(FunTypes type) {
    switch (type) {
      case FunTypes.WATCH_MOVIES:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => WatchMovieList()));
        break;
      case FunTypes.MOVIE_LINES:
        Navigator.push(context, MaterialPageRoute(builder: (_) => LinePage()));
        break;
      case FunTypes.MOVIE_QUOTES:
        // TODO: Handle this case.
        break;
      case FunTypes.MOVIE_SCRIPTS:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => MovieScript()));
        break;
    }
    // switch(kind){
    //   case 0:
    //   Navigator.pushNamed(context, '/Movie Lines');
    //   return;
    //   case 1:
    //   return;
    //   case 2:
    //   Navigator.pushNamed(context, '/Movie Scripts');

    //   return;
    //   case 3:
    //   return;
    // }
  }
}
