import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_bucket_list/components/common/default_text.dart';

import '../../globle/constants.dart';

class IconTextWidget extends StatelessWidget {
  final String desc;
  final IconData iconData;
  const IconTextWidget({Key? key, required this.desc, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double relativeWidth = size.width / Constants.referenceWidth;
    double relativeHeight = size.height / Constants.referenceHeight;
    return Row(
      children: [
        Icon(
          iconData,
          color: Color.fromRGBO(25, 30, 29, 1),
          size: 24,
        ),
        SizedBox(width: relativeWidth * 8),
        DefaultText(
          colorR: Color.fromRGBO(25, 30, 29, 1),
          content: desc,
          fontSizeR: 16,
          fontWeightR: FontWeight.w400,
          textAlignR: TextAlign.start,
        ),
      ],
    );
  }
}
