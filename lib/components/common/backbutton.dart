import 'package:flutter/material.dart';
import 'package:movie_bucket_list/globle/constants.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double relativeWidth = size.width / Constants.referenceWidth;
    double relativeHeight = size.height / Constants.referenceHeight;
    return Padding(
      padding: EdgeInsets.only(
        left: relativeWidth * 15,
      ),
      child: Container(
        height: relativeHeight * 100,
        width: relativeWidth * 54,
        decoration: BoxDecoration(
            color: Color(0x8D000000),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15)),
        child: IconButton(
          icon: Padding(
            padding: EdgeInsets.only(
              right: relativeWidth * 15,
              bottom: relativeHeight * 10,
            ),
            child: const SizedBox(
              height: 16,
              width: 16,
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
