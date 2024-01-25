import 'package:flutter/material.dart';
import 'package:movie_bucket_list/components/common/default_text.dart';
import 'package:movie_bucket_list/components/details/iconText.dart';
import 'package:movie_bucket_list/components/details/releaseData.dart';
import 'package:movie_bucket_list/globle/constants.dart';

class NameAndTimeWidget extends StatelessWidget {
  final String name;
  final String date;
  final String time;
  final String rate;
  final List genres;

  final String summary;
  const NameAndTimeWidget(
      {super.key,
      required this.name,
      required this.summary,
      required this.date,
      required this.time,
      required this.rate,
      required this.genres});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double relativeWidth = size.width / Constants.referenceWidth;
    double relativeHeight = size.height / Constants.referenceHeight;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultText(
          // ignore: prefer_const_constructors
          colorR: const Color.fromRGBO(25, 30, 29, 1),
          content: name,
          fontSizeR: 24,
          fontWeightR: FontWeight.w600,
          textAlignR: TextAlign.start,
        ),
        SizedBox(
          height: relativeHeight * 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: time != '-- . --' ? true : false,
              child: IconTextWidget(
                desc: time,
                iconData: Icons.watch_later_rounded,
              ),
            ),
            Visibility(
              visible: rate != '-- / 10' ? true : false,
              child: IconTextWidget(
                desc: rate,
                iconData: Icons.star_border_outlined,
              ),
            ),
          ],
        ),
        Divider(),
        ReleaseDataWidget(
          date: date,
          genres: genres,
        ),
        Divider(),
        SizedBox(
          height: relativeHeight * 10,
        ),
        Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: DefaultText(
                colorR: Color.fromRGBO(25, 30, 29, 1),
                content: "Description",
                fontSizeR: 20,
                fontWeightR: FontWeight.w600,
                textAlignR: TextAlign.start,
              ),
            ),
            SizedBox(
              height: relativeHeight * 10,
            ),
            DefaultText(
              colorR: Color.fromRGBO(25, 30, 29, 1),
              content: summary,
              fontSizeR: 16,
              fontWeightR: FontWeight.w400,
              textAlignR: TextAlign.start,
            ),
          ],
        ),
      ],
    );
  }
}
