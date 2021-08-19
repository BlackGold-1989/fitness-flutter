import 'package:fitness/generated/l10n.dart';
import 'package:fitness/services/navigator_service.dart';
import 'package:fitness/services/network_service.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/widgets/button_widget.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:fitness/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  var isPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();

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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(offsetBase),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 120.0,
                ),
                SizedBox(
                  height: offsetXLg,
                ),
                Text(
                  S.of(context).create_new_account,
                  style: GoogleFonts.montserrat(
                      fontSize: fontLg, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: offsetXLg,
                ),
                NoOutLineTextField(
                  margin: EdgeInsets.only(top: 2.0),
                  controller: nameController,
                  hintText: S.of(context).full_name,
                  prefixIcon: Icons.account_circle_outlined,
                  keyboardType: TextInputType.name,
                ),
                NoOutLineTextField(
                  margin: EdgeInsets.only(top: 2.0),
                  controller: emailController,
                  hintText: S.of(context).email_address,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                NoOutLineTextField(
                  margin: EdgeInsets.only(top: 2.0),
                  controller: passController,
                  hintText: S.of(context).password,
                  prefixIcon: UniconsLine.lock,
                  isHidden: isPassword,
                  suffixWidget: InkWell(
                    child: Icon(Icons.remove_red_eye_sharp),
                    onTap: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: offsetBase),
                  child: FullWidthButton(
                    title: S.of(context).create_account,
                    action: () => _register(),
                  ),
                ),
                SizedBox(
                  height: offsetXLg,
                ),
                Text(
                  S.of(context).already_account,
                  style: GoogleFonts.montserrat(fontSize: fontBase),
                ),
                SizedBox(
                  height: offsetSm,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    S.of(context).goto_login,
                    style: GoogleFonts.montserrat(
                        fontSize: fontMd, fontWeight: FontWeight.w600),
                  ),
                ),
                Spacer(),
                Text(
                  S.of(context).desc_term_price,
                  style: GoogleFonts.montserrat(fontSize: fontSm),
                ),
                SizedBox(
                  height: offsetSm,
                ),
                Text(
                  S.of(context).term_price,
                  style: GoogleFonts.montserrat(
                      fontSize: fontSm, color: Colors.greenAccent),
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

  Future<void> _register() async {
    String name = nameController.text;
    if (name.length < 2) {
      NavigatorService(context).showSnackbar(
          S.of(context).alt_name_error, _scaffoldKey,
          type: SnackBarType.ERROR);
      return;
    }
    String email = emailController.text;
    if (email.isEmpty || !email.contains('@')) {
      NavigatorService(context).showSnackbar(
          S.of(context).alert_email_error, _scaffoldKey,
          type: SnackBarType.ERROR);
      return;
    }
    String pass = passController.text;
    if (pass.isEmpty) {
      NavigatorService(context).showSnackbar(
          S.of(context).alert_password_error, _scaffoldKey,
          type: SnackBarType.ERROR);
      return;
    }

    var param = {'email': email, 'password': pass, 'name': name};
    var resp = await NetworkService(context)
        .ajax('Auth', 'fitness_register', param, isProgress: true);
    if (resp['ret'] == 10000) {
      Navigator.of(context).pop(resp['msg']);
    } else {
      NavigatorService(context)
          .showSnackbar(resp['msg'], _scaffoldKey, type: SnackBarType.ERROR);
    }
  }
}
