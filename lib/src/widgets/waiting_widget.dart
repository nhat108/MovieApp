import 'package:flutter/cupertino.dart';

class WaitingWidget extends StatelessWidget {
  final double padding;

  const WaitingWidget({Key key, this.padding = 50}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      child: CupertinoActivityIndicator(),
    );
  }
}
