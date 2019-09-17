import 'package:flutter/material.dart';

class ErrorUtils {
  static getErrorTrending(BuildContext context) => Container(
        margin: EdgeInsets.all(8),
        alignment: AlignmentDirectional.center,
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.grey),
        child: Text('Something was wrong'),
      );
  static getErrorPersonAvatar() => Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10000)),
        child: Icon(
          Icons.person,
          size: 80,
          color: Colors.grey[800],
        ),
      );
  static getErrorPersonCard() => Container(
        width: 78,
        height: 110,
        color: Colors.grey,
        child: Icon(
          Icons.person,
          size: 60,
        ),
      );
  static getErrorPoster() => Container(
        color: Colors.grey,
        alignment: AlignmentDirectional.center,
        child: Icon(Icons.movie),
      );
  static getErrorBackDrop() => Image.asset(
        'assets/images/astronaut.png',
        fit: BoxFit.cover,
      );
  static getErrorBackgroundPerson() =>
      Image.asset('assets/images/astronaut.png',fit: BoxFit.cover,);
}
