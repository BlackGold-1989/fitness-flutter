import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FullWidthButton extends FlatButton {
  FullWidthButton({
    Key key,
    String title,
    Widget customTitleWidget,
    Color color = Colors.blueAccent,
    void Function() action,
    Color textColor = Colors.white,
    double buttonRadius = offsetXSm,
    double height = 54.0,
    EdgeInsets margin = EdgeInsets.zero,
  }) : super(
          key: key,
          child: Container(
            height: height,
            alignment: Alignment.center,
            width: double.maxFinite,
            margin: margin,
            child: customTitleWidget == null
                ? Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontSize: fontBase, fontWeight: weightSemiBold),
                  )
                : customTitleWidget,
          ),
          onPressed: action,
          color: color,
          disabledColor: color.withOpacity(0.5),
          textColor: textColor,
          disabledTextColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        );
}

class OutlineEmptyButton extends StatelessWidget {
  final double height;
  final String title;
  final Widget titleWidget;
  final Function() onPress;

  const OutlineEmptyButton(
      {Key key, this.height = 54.0, this.title, this.titleWidget, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress(),
      child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(offsetSm)),
            border: Border.all(color: Colors.white, width: 1),
            color: Colors.white.withOpacity(0.2),
          ),
          child: Center(
            child: titleWidget == null
                ? Text(
                    title,
                    style: GoogleFonts.montserrat(
                        fontSize: fontBase, fontWeight: weightSemiBold),
                  )
                : titleWidget,
          )),
    );
  }
}
