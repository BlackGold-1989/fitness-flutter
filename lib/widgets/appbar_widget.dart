import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends AppBar {
  CustomAppbar(
      {Key key,
      List<Widget> actions,
      @required String title,
      Widget lendingWidget})
      : super(
          backgroundColor: Colors.white.withOpacity(0.2),
          leading: lendingWidget,
          title: Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: fontMd, fontWeight: weightSemiBold),
          ),
          centerTitle: true,
          actions: actions,
        );
}
