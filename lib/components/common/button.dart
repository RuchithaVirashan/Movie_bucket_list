import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonName;
  final Color bcolor;
  final Color fcolor;
  final Color tcolor;
  final double radius;
  final double minHeight;
  final Color borderColor;
  final void Function()? onPressed;
  final double spacing;
  final double iconSize;

  const ButtonWidget({
    Key? key,
    required this.buttonName,
    required this.bcolor,
    required this.tcolor,
    required this.radius,
    required this.fcolor,
    required this.minHeight,
    required this.borderColor,
    required this.onPressed,
    this.iconSize = 24.0,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bcolor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        ),
        minimumSize:
            MaterialStateProperty.all(Size(double.infinity, minHeight)),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8.0,
          ),
        ),
      ),
      onPressed: () {
        onPressed!();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            buttonName,
            style: TextStyle(
              color: fcolor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(width: spacing), // Add spacing between text and icon
          Icon(
            Icons.favorite,
            color: tcolor,
            size: iconSize,
          ),
        ],
      ),
    );
  }
}
