import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/constants/colors.dart';
import 'package:nux_movie/src/ui/about_page.dart';
import 'package:nux_movie/src/ui/fun_page.dart';
import 'package:nux_movie/src/ui/movies_page.dart';
import 'package:nux_movie/src/ui/review_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:nux_movie/src/widgets/nux_bottom_bar.dart';
import 'package:nux_movie/src/widgets/offline.dart';
import '../blocs/movies_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOnline = false;
  int _selectedIndex = 0;

  List<Widget> pages = List<Widget>();

  StreamSubscription connection;
  @override
  void initState() {
    super.initState();
    pages.add(MoviesPage());
    pages.add(ReviewPage());
    pages.add(FunPage());
    pages.add(AboutPage());
    connection = Connectivity().onConnectivityChanged.listen((onData) {
      if (onData == ConnectivityResult.mobile ||
          onData == ConnectivityResult.wifi) {
        print("Connected to network");
        setState(() {
          isOnline = true;
        });
      } else {
        print("Unable to connect. Please Check Internet Connection");
        setState(() {
          isOnline = false;
        });
      }
    });
  }


  @override
  void dispose() {
    connection.cancel();
    bloc.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
        body: isOnline
            ? IndexedStack(
                children: pages,
                index: _selectedIndex,
              )
            : OfflineWidget());
  }

  _bottomNavigationBar(int selectedIndex) => NuxBottomNavigationBar(
        selectedIndex: _selectedIndex,
        animationDuration: Duration(milliseconds: 200),
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Color(kPrimaryDarkColor),
        items: [
          NuxBottomBarItem(
            icon: Icon(Icons.movie_filter),
            title: Text('Movie'),
            activeColor: Colors.red,
          ),
          NuxBottomBarItem(
              icon: Icon(Icons.rate_review),
              title: Text('Review'),
              activeColor: Colors.yellowAccent),
          NuxBottomBarItem(
              icon: Icon(Icons.face),
              title: Text('Quotes'),
              activeColor: Colors.purpleAccent),
          NuxBottomBarItem(
              icon: Icon(Icons.settings),
              title: Text('About'),
              activeColor: Colors.blue)
        ],
      );
}
