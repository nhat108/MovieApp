class MovieGD{
  final String id;
  final String link;

  MovieGD({this.id, this.link});
  factory MovieGD.fromJson(Map<String,dynamic>json){
    return MovieGD(
        id: json['id'],
        link: json['link']
    );
  } 
  
}