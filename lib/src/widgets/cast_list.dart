import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/ui/person_page.dart';
import 'package:nux_movie/src/utils/error.dart';

// class CastList extends StatefulWidget {
//   final List<Cast> casts;
//   CastList({this.casts});
//   @override
//   State<StatefulWidget> createState() => CastListState();
// }

class CastList extends StatelessWidget {
  final List<Cast>casts;

  const CastList({Key key, this.casts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Color(0xFF2d3447), borderRadius: BorderRadius.circular(5.0)),
      child: Container(
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: casts.length - 1,
          itemBuilder: (context, index) {
            return GestureDetector(

              onTap: () {
                String path=casts[index].profilePath;

                openPersonPage(
                    casts[index].id, path==null?'':path,context);
              },
              child: Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w185/${casts[index].profilePath}',
                        placeholder: (context, url) => Container(
                          width: 78,
                          height: 110,
                          color: Colors.grey,
                        ),
                        errorWidget: (context, url, error) => ErrorUtils.getErrorPersonCard(),
                        width: 78,
                        height: 110,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: 78,
                      child: Text(
                        casts[index].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                        width: 78,
                        child: Text(
                          casts[index].character,
                          maxLines: 2,
                          style:
                              TextStyle(fontSize: 10, color: Color(0xFFffe3d8)),
                        ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  openPersonPage(int id, String profilePath,context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonPage(
          id: id,
          profilePath: profilePath,
        ),
      ),
    );
  }
}
