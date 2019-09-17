import 'package:flutter/material.dart';

class BiographyCard extends StatefulWidget {
  final String biography;
  final String personName;
  BiographyCard({this.biography, this.personName});
  @override
  _BiographyCardState createState() => _BiographyCardState();
}

class _BiographyCardState extends State<BiographyCard> {
  String firstHalf;
  String seccondHalf;
  bool flag = true;
  @override
  void initState() {
    super.initState();
    if (widget.biography.length > 400) {
      firstHalf = widget.biography.substring(0, 400);
      seccondHalf = widget.biography.substring(400, widget.biography.length);
    } else {
      firstHalf = widget.biography;
      seccondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.biography.length <= 0)
      return Text(
        "We don't have a biography for ${widget.personName}",
        style: Theme.of(context).textTheme.subtitle,
      );
    return Container(
      child: seccondHalf.isEmpty
          ? Text(
              firstHalf,
              style: Theme.of(context).textTheme.subtitle,
            )
          : Column(
              children: <Widget>[
                Text(flag ? (firstHalf + '...') : (firstHalf + seccondHalf)),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? 'show more' : 'show less',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                )
              ],
            ),
    );
  }
}
