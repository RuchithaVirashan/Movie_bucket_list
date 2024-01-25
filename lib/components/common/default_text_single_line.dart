import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DefaultTextSingleLine extends StatelessWidget {
  final String content;
  final double fontSizeR;
  final Color colorR;
  final TextAlign textAlignR;
  final FontWeight fontWeightR;

  const DefaultTextSingleLine({
    Key? key,
    required this.content,
    required this.fontSizeR,
    required this.colorR,
    required this.textAlignR,
    required this.fontWeightR,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      overflow: TextOverflow.fade,
      maxLines: 1,
      softWrap: false,
      style: TextStyle(
        fontSize: fontSizeR,
        fontWeight: fontWeightR,
        color: colorR,
      ),
      textAlign: textAlignR,
    );
  }
}
