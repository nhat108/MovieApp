import 'package:cloud_firestore/cloud_firestore.dart';

class Video{
  String url;
  String thumnail;
  String title;
  String image;
  String description;
  String color;
  String website;
  Video({this.url,this.thumnail,this.title,this.image,this.color,this.description,this.website});
  factory Video.fromFireStore(DocumentSnapshot doc){
    Map map=doc.data;
    return Video(
      url: map['url'],
      thumnail: map['thumnail'],
      title: map['title'],
      image: map['image'],
      color: map['color'],
      description: map['description'],
      website:map['website'],
    );
  }
  Map<String,dynamic> toMap(){
    return{
      'url':url,
      'thumnail':thumnail,
      'title':title,
      'image':image,
      'color':color,
      'description':description,
      'website':website
    };
  }
}