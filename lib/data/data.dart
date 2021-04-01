import 'package:flutter/material.dart';

const customPrimaryColor = const Color(0xff424250);
const customSecondaryColor = const Color(0xff33333d);
final customFieldColor = const Color(0xff25282f).withOpacity(0.18);
const customWhite = const Color(0xffffffff);
const customButtonTextColor = const Color(0xff1eb980);
const customTextColor = const Color(0xffa2a2a2);
const customIconColor = const Color(0xffadadb1);

const double appBarIconH = 30;
const double appBarIconW = 30;

getDeviceWidth(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);
  return mediaQueryData.size.width;
}

getDeviceHeight(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);
  return mediaQueryData.size.height;
}
