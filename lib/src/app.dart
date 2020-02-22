import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/constants/colors.dart';
import 'package:nux_movie/src/ui/home_page.dart';
class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale.cachedLocale,
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