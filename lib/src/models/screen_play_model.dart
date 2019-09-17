import 'package:cloud_firestore/cloud_firestore.dart';

class ScreenPlay{
   String url;
   String thumnail;
   String movieName;
   String title;
   String id;

  ScreenPlay({this.url, this.thumnail,this.title, this.movieName, this.id});

  factory ScreenPlay.fromFireStore(DocumentSnapshot doc){
    Map map=doc.data;
    return ScreenPlay(
      url: map['url'],
      thumnail: map['thumnail'],
      movieName: map['movieName'],
      id:map['id'],
      title: map['title']
    );
  }

  Map<String,dynamic>toMap(){
    return{
      'url':url,
      'thumnail':thumnail,
      'movieName':movieName,
      'title':title,
      'id':id
    };
  }
}