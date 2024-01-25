import 'dart:io';

class Constants {
  static const referenceHeight = 812;
  static const referenceWidth = 375;
  String currentPlatfrom = Platform.isAndroid
      ? "android"
      : Platform.isIOS
          ? "iOS"
          : "other";
}
