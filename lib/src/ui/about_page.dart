import 'package:flutter/material.dart';
import 'package:nux_movie/src/constants/colors.dart';
import 'package:nux_movie/src/utils/utils.dart';


class AboutPage extends StatelessWidget {
  const AboutPage({Key key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(kPrimaryColor),
        body: SafeArea(
          child: Container(
            height: height,
            padding: EdgeInsets.all(20 ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: FlutterLogo(
                    size: 80,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Novie Application',
                    style: TextStyle(
                      fontFamily: 'Aller',
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 1.6,
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'V 1.0',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '"I have to realize that is not the attitude or behavior of a leader, of a martial artist or a champion.\n' +
                      'I must get my head screwed on and get back in the game, fight for redemption, retribution, respect - the things that made me the man I am."' +
                      '\n-Conor McGregor-',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontFamily: 'Aller',
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                // SizedBox(
                //   height: height * 0.1,
                // ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('DEVELOP BY'),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Utils.launchURL('https://www.facebook.com/nux108');
                        },
                        child: Text(
                          'NUX_108',
                          style: TextStyle(
                            fontFamily: 'ChunkFive',
                            fontSize: 20,
                            color: Colors.blue[600],
                          ),
                        ),
                      ),
                      
                      SizedBox(
                        height: 15,
                      ),
                      Text('BUILD WITH'),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          FlutterLogo(
                            size: 40,
                          ),
                          Text(
                            'Flutter',
                            style: TextStyle(fontSize: 30),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
