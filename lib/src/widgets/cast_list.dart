import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/ui/person_page.dart';
import 'package:nux_movie/src/utils/error.dart';
import 'package:nux_movie/src/widgets/custom_cached_network_image.dart';

class CastList extends StatelessWidget {
  final List<Cast> casts;

  const CastList({Key key, this.casts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF2d3447), borderRadius: BorderRadius.circular(5.0)),
      child: Container(
        height: 180,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: casts.length,
            itemBuilder: (context, index) {
              return _item(casts[index], context);
            }),
      ),
    );
  }

  _item(Cast cast, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToPersonPage(cast.id, cast.profilePath??'', context);
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
              child: CustomCachedNetWorkImage(
                photoUrl: cast.profilePath,
                width: 78,
                height: 110,
                errorWidget: Container(
                  width: 78,
                  height: 110,
                  child: ErrorUtils.getErrorPersonCard(),
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              width: 78,
              child: Text(
                cast.name,
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
                  cast.character,
                  maxLines: 2,
                  style: TextStyle(fontSize: 10, color: Color(0xFFffe3d8)),
                ))
          ],
        ),
      ),
    );
  }

  _navigateToPersonPage(int id, String profilePath, context) {
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
