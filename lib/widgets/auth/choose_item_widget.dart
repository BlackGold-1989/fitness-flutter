import 'package:fitness/themes/dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class TextChooseWidget extends Container {
  TextChooseWidget({Key key, @required String title, bool isChecked = false})
      : super(
    margin: EdgeInsets.symmetric(vertical: offsetXSm / 2),
    padding: EdgeInsets.symmetric(horizontal: offsetBase),
    width: double.infinity,
    height: 60.0,
    color: Colors.white.withOpacity(0.1),
    child: Row(
      children: [
        Text(title, style: GoogleFonts.montserrat(fontSize: fontMd, fontWeight: FontWeight.w400),),
        Spacer(),
        Icon(UniconsLine.check, color: isChecked? Colors.white : Colors.transparent,),
      ],
    )
  );
}
