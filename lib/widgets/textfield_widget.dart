import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoOutLineTextField extends Container {
  NoOutLineTextField({
    Key key,
    @required TextEditingController controller,
    @required String hintText,
    EdgeInsets margin = EdgeInsets.zero,
    double height = 54.0,
    @required IconData prefixIcon,
    Widget suffixWidget,
    bool isHidden = false,
    TextInputType keyboardType = TextInputType.text,
  }) : super(
            height: height,
            margin: margin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(offsetXSm)),
              color: Colors.white.withOpacity(0.1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(offsetXSm)),
              child: Row(
                children: [
                  Container(
                    width: height,
                    color: Colors.white.withOpacity(0.2),
                    child: Center(
                      child: Icon(prefixIcon),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: offsetSm),
                    child: TextField(
                      controller: controller,
                      keyboardType: keyboardType,
                      style: GoogleFonts.montserrat(
                          fontSize: fontBase, fontWeight: weightMedium),
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: GoogleFonts.montserrat(
                            fontSize: fontBase,
                            color: Colors.grey,
                            fontWeight: weightLight),
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      obscureText: isHidden,
                    ),
                  )),
                  if (suffixWidget != null)
                    Container(
                      width: height,
                      color: Colors.white.withOpacity(0.2),
                      child: Center(
                        child: suffixWidget,
                      ),
                    ),
                ],
              ),
            ));
}
