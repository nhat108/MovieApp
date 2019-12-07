import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String fontFamily;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final int maxLines;
  final TextOverflow overflow;
  const CustomText(
    this.text,
      {Key key,
      this.fontFamily,
      this.textColor,
      this.fontSize,
      this.fontWeight, this.overflow, this.maxLines=1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow??TextOverflow.ellipsis,
      style: TextStyle(
          fontFamily: fontFamily,
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}
