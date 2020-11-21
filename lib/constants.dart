import 'package:flutter/material.dart';

double sizeFromHeight(BuildContext context, double fraction,
    {bool removeAppBarSize = true}) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  fraction = (removeAppBarSize
          ? (mediaQuery.size.height -
              AppBar().preferredSize.height -
              mediaQuery.padding.top - mediaQuery.padding.bottom)
          : mediaQuery.size.height) /
      (fraction == 0 ? 1 : fraction);
  return fraction;
}

double sizeFromWidth(BuildContext context, double fraction) {
  fraction = MediaQuery.of(context).size.width / (fraction == 0 ? 1 : fraction);
  return fraction;
}
