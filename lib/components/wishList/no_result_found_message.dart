import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../globle/constants.dart';
import '../common/default_text.dart';

class NoResultFondMesWishList extends StatelessWidget {
  const NoResultFondMesWishList({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double relativeWidth = size.width / Constants.referenceWidth;
    double relativeHeight = size.height / Constants.referenceHeight;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
            top: relativeHeight * 100.0,
            left: relativeWidth * 20.0,
            right: relativeWidth * 20.0),
        child: Opacity(
          opacity: 0.9,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(237, 237, 237, 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Image(
                    image: NetworkImage(
                        'https://img.freepik.com/premium-vector/error-document-illustration_585024-40.jpg'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: relativeHeight * 20.0,
                    ),
                    child: const DefaultText(
                      colorR: Color.fromRGBO(25, 30, 29, 1),
                      content:
                          'Uh oh! No items found in your wishlist yet. Add some items and check again for some delightful treats! 🎁🛍️',
                      fontSizeR: 16,
                      fontWeightR: FontWeight.w400,
                      textAlignR: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
