import 'package:flutter/material.dart';

import '../../globle/constants.dart';
import '../common/default_text_single_line.dart';

class MovieCardWishList extends StatelessWidget {
  final List movieDetails;
  final void Function()? onPressed;
  final int index;
  final void Function()? onPressedWish;

  const MovieCardWishList({
    super.key,
    required this.movieDetails,
    required this.onPressed,
    required this.index,
    required this.onPressedWish,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double relativeWidth = size.width / Constants.referenceWidth;
    double relativeHeight = size.height / Constants.referenceHeight;
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color.fromRGBO(237, 237, 237, 1),
        ),
        child: InkWell(
          onTap: () {
            onPressed!();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: relativeHeight * 8,
              horizontal: relativeWidth * 8,
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        movieDetails[index]['_embedded']['show']['image'] !=
                                null
                            ? movieDetails[index]['_embedded']['show']['image']
                                ['medium']
                            : 'https://eticketsolutions.com/demo/themes/e-ticket/img/movie.jpg',
                        fit: BoxFit.cover,
                        // width: relativeWidth * 186,
                        // height: relativeHeight * 214,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: relativeHeight * 16,
                        horizontal: relativeWidth * 16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextSingleLine(
                            colorR: const Color.fromRGBO(25, 30, 29, 1),
                            content: movieDetails[index]['name'].toString(),
                            fontSizeR: 14,
                            fontWeightR: FontWeight.w600,
                            textAlignR: TextAlign.start,
                          ),
                          SizedBox(height: relativeHeight * 4),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: relativeHeight * 50,
                      width: relativeWidth * 50,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(25, 30, 29, .9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        icon: SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            'assets/remove.png',
                          ),
                        ),
                        onPressed: () {
                          onPressedWish!();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
