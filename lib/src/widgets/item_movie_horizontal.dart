import 'package:flutter/material.dart';
import 'package:nux_movie/src/constants/colors.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/utils/utils.dart';
import 'package:nux_movie/src/widgets/custom_cached_network_image.dart';
import 'package:nux_movie/src/widgets/custom_text.dart';

class ItemMovieHorizontal extends StatelessWidget {
  final Result result;
  final VoidCallback onTap;

  const ItemMovieHorizontal({Key key, this.result, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        height: 175,
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        key: Key('{$result.id}'),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomCachedNetWorkImage(
              photoUrl: result.posterPath,
              width: MediaQuery.of(context).size.width * 0.35,
              height: 175,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomText(
                    result.title,
                    textColor: Color(kTextColor2),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  CustomText(
                    Utils.getGenresList(result.genreIds),
                    fontWeight: FontWeight.w500,
                    textColor: Color(kWhiteTextColor),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text('${result.voteAverage}')
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}