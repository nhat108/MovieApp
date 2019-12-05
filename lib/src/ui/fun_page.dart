import 'package:flutter/material.dart';
import 'package:nux_movie/src/utils/colors.dart';

class FunPage extends StatefulWidget {
  const FunPage({Key key}) : super(key: key);

  @override
  _FunPageState createState() => _FunPageState();
}

enum KindFun {
  movie_lines,
  movie_quotes,
  movie_scripts,
}

class _FunPageState extends State<FunPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(MovieColor.kPrimaryColor),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          // padding: EdgeInsets.only(top: 20,bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _item(
                  kind: KindFun.movie_lines.index,
                  title: 'Movie Lines',
                  image: 'assets/images/joker.jpg'),
              SizedBox(
                height: 20,
              ),
              _item(
                  kind: KindFun.movie_scripts.index,
                  title: 'Movie Scripts',
                  image: 'assets/images/script.png'),
            ],
          ),
        ),
      ),
    );
  }

  _item({String title, String image, Color color, int kind}) {
    var width=MediaQuery.of(context).size.width;
     var height=MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
          openFunPage(kind);
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
                width:width*0.8,
                height: height*0.4,
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
  openFunPage(int kind){
    switch(kind){
      case 0:
      Navigator.pushNamed(context, '/Movie Lines');
      return;
      case 1:
      return;
      case 2:
      Navigator.pushNamed(context, '/Movie Scripts');

      return;
      case 3:
      return;
    }
  }
}
