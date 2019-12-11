import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nux_movie/src/models/item_movie_gd.dart';
import 'package:nux_movie/src/models/item_video.dart';
import 'package:nux_movie/src/models/screen_play_model.dart';

import 'movie_lines.dart';

class DatabaseService {
  String query;
  DatabaseService({this.query});
  final Firestore _db = Firestore.instance;

  Stream<List<Video>> getStreamVideos() {
    return _db.collection('youtube').snapshots().map((convert) =>
        convert.documents.map((doc) => Video.fromFireStore(doc)).toList());
  }
  Stream<List<ScreenPlay>>getStreamSripts(){
    return _db.collection('screenplayed').snapshots().map((convert)=>
      convert.documents.map((doc)=>ScreenPlay.fromFireStore(doc)).toList()
    );
  }
   Stream<List<Line>>getStreamLines(){
    return _db.collection('lines').snapshots().map((convert)=>
      convert.documents.map((doc)=>Line.fromFireStore(doc)).toList()
    );
  }
  Future createModel()async{
     for(int i=1;i<=20;i++){
       Line line=Line(
         id: '',
         imageUrl: '',
         movieName: '',
         title: '',
       );
      _db.collection('lines').document().setData(line.toMap());    
    }
  }
   Stream<List<MovieGD>>getAllMovies(){
    return _db.collection('movies').snapshots().map((i){
       return i.documents.map((doc){
          return MovieGD.fromJson(doc.data);
        }).toList();
    });
  }


}
