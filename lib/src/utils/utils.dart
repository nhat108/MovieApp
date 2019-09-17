import 'package:url_launcher/url_launcher.dart';

class Utils {
  static var genresMap = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Science Fiction',
    10770: 'TV movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western'
  };
  
  static String getGenres(int id) {
    String genres = genresMap[id];
    if (genres != null) {
      return genres;
    } else {
      return 'Unknow';
    }
  }

  static String getGenresList(List<int> ids) {
    String genres = '';
    for (int i = 0; i <= ids.length - 1; i++) {
      if (i == ids.length - 1) {
        genres += Utils.getGenres(ids[i]) + '.';
      } else {
        genres += Utils.getGenres(ids[i]) + ', ';
      }
    }
    return genres;
  }

  static int getAge(String yearOfBirth) {
    if (yearOfBirth == null) return 0;
    
    var birth = DateTime.parse(yearOfBirth);
    var days = birth.difference(DateTime.now());
    return -(days.inDays / 365).floor();
  }

  static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
