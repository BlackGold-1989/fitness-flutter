import 'package:fitness/themes/colors.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigatorService {
  final BuildContext context;

  NavigatorService(this.context);

  void pushToWidget({
    @required Widget screen,
    bool replace = false,
    Function(dynamic) pop,
  }) {
    if (replace) {
      Navigator.of(context)
          .pushReplacement(
              MaterialPageRoute<Object>(builder: (context) => screen))
          .then((value) => {if (pop != null) pop(value)});
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute<Object>(builder: (context) => screen))
          .then((value) => {if (pop != null) pop(value)});
    }
  }

  void showCustomBottomModal(Widget child) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(offsetBase),
            topLeft: Radius.circular(offsetBase),
          ),
        ),
        backgroundColor: backgroundColor,
        builder: (_) => Container(
              padding: EdgeInsets.all(offsetBase),
              child: child,
            ));
  }

  void showSnackbar(
    String content,
    GlobalKey<ScaffoldState> _scaffoldKey, {
    SnackBarType type = SnackBarType.SUCCESS,
  }) {
    var backgroundColor = Colors.white;
    switch (type) {
      case SnackBarType.SUCCESS:
        backgroundColor = Colors.green;
        break;
      case SnackBarType.WARING:
        backgroundColor = Colors.orange;
        break;
      case SnackBarType.INFO:
        backgroundColor = Colors.blueGrey;
        break;
      case SnackBarType.ERROR:
        backgroundColor = Colors.red;
        break;
    }

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Card(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(offsetSm)),
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.all(offsetBase),
          child: Text(
            content,
            style: GoogleFonts.montserrat(
                fontSize: fontMd, fontWeight: FontWeight.w300),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: Duration(milliseconds: 1500),
    ));
  }

  Future<dynamic> showCustomDialog(List<Widget> widgets) async {
    return await showDialog<dynamic>(
        context: context,
        builder: (context) => GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.all(offsetBase),
                  child: Center(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 45.0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(offsetSm)),
                            child: Container(
                              padding: EdgeInsets.all(offsetBase),
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: widgets,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Container(
                              width: 90.0,
                              height: 90.0,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                border: Border.all(
                                    color: Colors.white, width: offsetSm),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60.0)),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  width: 48.0,
                                  height: 48.0,
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

enum SnackBarType { SUCCESS, WARING, INFO, ERROR }
