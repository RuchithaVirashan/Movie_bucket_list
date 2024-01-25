import 'package:flutter/material.dart';
import 'package:movie_bucket_list/components/common/default_text.dart';
import 'package:movie_bucket_list/globle/constants.dart';

class ReleaseDataWidget extends StatelessWidget {
  final String date;
  final List genres;
  const ReleaseDataWidget(
      {super.key, required this.date, required this.genres});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double relativeWidth = size.width / Constants.referenceWidth;
    double relativeHeight = size.height / Constants.referenceHeight;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const DefaultText(
              colorR: Color.fromRGBO(25, 30, 29, 1),
              content: "Release date",
              fontSizeR: 20,
              fontWeightR: FontWeight.w600,
              textAlignR: TextAlign.start,
            ),
            DefaultText(
              colorR: const Color.fromRGBO(25, 30, 29, 1),
              content: date,
              fontSizeR: 14,
              fontWeightR: FontWeight.w400,
              textAlignR: TextAlign.start,
            ),
          ],
        ),
        SizedBox(
          width: genres.length >= 2 ? relativeWidth * 40 : relativeWidth * 80,
        ),
        Visibility(
          visible: genres.isNotEmpty ? true : false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DefaultText(
                colorR: Color.fromRGBO(25, 30, 29, 1),
                content: "Genre",
                fontSizeR: 20,
                fontWeightR: FontWeight.w600,
                textAlignR: TextAlign.start,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: genres.isNotEmpty ? true : false,
                    child: SizedBox(
                      width: relativeWidth * 80,
                      height: relativeHeight * 35,
                      child: Stack(
                        children: [
                          Container(
                            width: relativeWidth * 80,
                            height: relativeHeight * 35,
                            decoration: ShapeDecoration(
                              color: Colors.black.withOpacity(0.05),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              genres.isNotEmpty ? genres[0] : 'Not specific',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: relativeWidth * 5,
                  ),
                  Visibility(
                    visible: genres.length >= 2 ? true : false,
                    child: SizedBox(
                      width: relativeWidth * 80,
                      height: relativeHeight * 35,
                      child: Stack(
                        children: [
                          Container(
                            width: relativeWidth * 80,
                            height: relativeHeight * 35,
                            decoration: ShapeDecoration(
                              color: Colors.black.withOpacity(0.05),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          // Text overlay
                          Center(
                            child: Text(
                              genres.length >= 2 ? genres[1] : 'Not specific',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
