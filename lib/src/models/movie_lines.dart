import 'package:cloud_firestore/cloud_firestore.dart';

class Line{
  final String title;
  final String movieName;
  final String imageUrl;
  final String id;

  Line({this.title, this.movieName, this.imageUrl, this.id});

  factory Line.fromFireStore(DocumentSnapshot doc){
    Map map=doc.data;
    return Line(
      title: map['title'],
      movieName: map['movieName'],
      imageUrl: map['imageUrl'],
      id: map['id']
    );
  }

  Map<String,dynamic>toMap(){
    return {
      'title':title,
      'movieName':movieName,
      'imageUrl':imageUrl,
      'id':id
    };
  }
}