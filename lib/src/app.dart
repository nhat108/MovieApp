import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/contants/colors.dart';
import 'package:nux_movie/src/ui/home_page.dart';
import 'package:nux_movie/src/ui/line_page.dart';
import 'package:nux_movie/src/ui/movie_scripts_page.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/Movie Scripts':(context)=>MovieScript(),
        '/Movie Lines':(context)=>LinePage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        backgroundColor: Color(kPrimaryDarkColor),
        primaryColorDark: Color(kPrimaryDarkColor),
        platform: TargetPlatform.iOS
      ),
      
      home: HomePage()
    );
  }
}