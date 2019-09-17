import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/models/item_model.dart';
import '../blocs/movies_bloc.dart';

class ImagesMovie extends StatefulWidget {
  final int id;
  ImagesMovie({@required this.id});
  @override
  _ImagesMovieState createState() => _ImagesMovieState();
}

class _ImagesMovieState extends State<ImagesMovie> {
  String titleMenu = 'Poster';
  int valueMenu = 1;
  var aspectRatio = 3 / 4;
  int axisCount = 3;

  @override
  void initState() {
    super.initState();
    bloc.fetchImages(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: Color(0xFF2c3549),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              width: 150,
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: _menu(),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: bloc.images,
                builder: (context, AsyncSnapshot<Images> snapshot) {
                  if (snapshot.hasData) {
                    List<Poster> list = valueMenu == 1
                        ? snapshot.data.posters
                        : snapshot.data.backdrops;
                    if (list.length > 0) {
                      return _imagesList(list);
                    } else {
                      return Center(
                        child: Text(
                          'Empty',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Icon(Icons.error),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _menu() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Posters"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Backdrops"),
          ),
        ],
        initialValue: valueMenu,
        onSelected: (value) {
          setState(() {
            valueMenu = value;
            titleMenu = value == 1 ? 'Posters' : 'Backdrops';

            if (valueMenu == 1) {
              aspectRatio = 3 / 4;
              axisCount = 3;
            } else {
              aspectRatio = 4 / 3;
              axisCount = 2;
            }
          });
        },
        child: Row(
          children: <Widget>[
            Text(
              titleMenu,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Icon(Icons.arrow_drop_down)
          ],
        ),
      );
  _imagesList(List<Poster> postes) {
    return Container(
      padding: EdgeInsets.all(4),
      child: GridView.count(
        childAspectRatio: aspectRatio,
        crossAxisCount: axisCount,
        children: List.generate(postes.length - 1, (i) {
          return Container(
            margin: EdgeInsets.all(8),
            child: CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500/${postes[i].filePath}',
              placeholder: (context, url) => Container(color: Colors.grey,),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          );
        }),
      ),
    );
  }
}
