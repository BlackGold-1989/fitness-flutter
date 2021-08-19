import 'package:fitness/generated/l10n.dart';
import 'package:fitness/services/navigator_service.dart';
import 'package:fitness/services/network_service.dart';
import 'package:fitness/services/pref_service.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:fitness/utils/constants.dart';
import 'package:fitness/widgets/button_widget.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:fitness/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyScreen extends StatefulWidget {
  final String email;

  const VerifyScreen({Key key, @required this.email}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      backImage: 'assets/images/img_back_02.png',
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: EdgeInsets.all(offsetBase),
            child: Column(
              children: [
                SizedBox(
                  height: offsetXLg,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: 120.0,
                ),
                SizedBox(
                  height: offsetXLg,
                ),
                Text(
                  S.of(context).send_code,
                  style: GoogleFonts.montserrat(
                      fontSize: fontBase, fontWeight: weightMedium),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: offsetSm,
                ),
                Text(
                  widget.email,
                  style: GoogleFonts.montserrat(
                      fontSize: fontMd, fontWeight: weightBold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: offsetMd,
                ),
                NoOutLineTextField(
                  controller: codeController,
                  hintText: S.of(context).verify_code,
                  prefixIcon: Icons.code,
                  keyboardType: TextInputType.text,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: offsetBase),
                  child: FullWidthButton(
                    title: S.of(context).submit,
                    action: () => _submit(),
                  ),
                ),
                SizedBox(
                  height: offsetMd,
                ),
                Text(
                  S.of(context).not_code,
                  style: GoogleFonts.montserrat(
                      fontSize: fontBase, fontWeight: weightLight),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: offsetSm,
                ),
                InkWell(
                  onTap: () async {
                    var param = {'email': widget.email};
                    var resp = await NetworkService(context).ajax(
                        'Auth', 'fitness_resend', param,
                        isProgress: true);
                    if (resp['ret'] == 10000) {
                      NavigatorService(context).showSnackbar(
                          S.of(context).resend_desc, _scaffoldKey,
                          type: SnackBarType.INFO);
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    S.of(context).resend,
                    style: GoogleFonts.montserrat(
                        fontSize: fontMd, fontWeight: weightBold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Text(
                  S.of(context).change_email_desc,
                  style: GoogleFonts.montserrat(
                      fontSize: fontSm, fontWeight: weightLight),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: offsetSm,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    S.of(context).change_email,
                    style: GoogleFonts.montserrat(
                        fontSize: fontMd,
                        fontWeight: weightBold,
                        color: Colors.green),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: offsetBase,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    var code = codeController.text;
    if (code.isEmpty) {
      NavigatorService(context).showSnackbar(
          S.of(context).code_error, _scaffoldKey,
          type: SnackBarType.ERROR);
      return;
    }
    var param = {
      'email': widget.email,
      'code': code,
    };

    FocusScope.of(context).unfocus();

    var resp = await NetworkService(context)
        .ajax('Auth', 'fitness_submit', param, isProgress: true);
    if (resp['ret'] == 10000) {
      var token = resp['result']['token'];
      await PrefService().setToken(token);
      Navigator.of(context)
          .pushReplacementNamed(Constants.route_main, arguments: 0);
    } else {
      Navigator.of(context).pop();
    }
  }
}
