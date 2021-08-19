import 'package:fitness/generated/l10n.dart';
import 'package:fitness/services/navigator_service.dart';
import 'package:fitness/services/network_service.dart';
import 'package:fitness/services/pref_service.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:fitness/utils/constants.dart';
import 'package:fitness/widgets/appbar_widget.dart';
import 'package:fitness/widgets/button_widget.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:fitness/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class ProfileScreen extends StatefulWidget {
  final dynamic data;
  const ProfileScreen({Key key, this.data}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var newPassController = TextEditingController();
  var confirmPassController = TextEditingController();

  var isPassword = false;
  var isNewPassword = false;
  var isConfirmPassword = false;
  var isChangePass = false;

  @override
  void initState() {
    super.initState();

    nameController.text = widget.data['name'];
    emailController.text = widget.data['email'];
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: CustomAppbar(
            title: S.of(context).my_profile,
            lendingWidget: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: offsetSm, vertical: offsetBase),
              child: Column(
                children: [
                  SizedBox(
                    height: offsetBase,
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    width: 120.0,
                  ),
                  SizedBox(
                    height: offsetXLg,
                  ),
                  Text(
                    'You are a ${widget.data['type']} member',
                    style: GoogleFonts.montserrat(
                        fontSize: fontMd, fontWeight: weightBold),
                  ),
                  SizedBox(
                    height: offsetBase,
                  ),
                  NoOutLineTextField(
                    controller: nameController,
                    hintText: S.of(context).fullname,
                    prefixIcon: Icons.account_circle_outlined,
                    keyboardType: TextInputType.text,
                  ),
                  NoOutLineTextField(
                    margin: EdgeInsets.only(top: 2.0),
                    controller: emailController,
                    hintText: S.of(context).email_address,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: offsetBase),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isChangePass = !isChangePass;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(isChangePass
                              ? Icons.check_box
                              : Icons.check_box_outline_blank),
                          SizedBox(
                            width: offsetSm,
                          ),
                          Text(S.of(context).change_password,
                              style: GoogleFonts.montserrat(
                                  fontSize: fontSm, fontWeight: weightMedium)),
                        ],
                      ),
                    ),
                  ),
                  if (isChangePass)
                    Column(
                      children: [
                        NoOutLineTextField(
                          margin: EdgeInsets.only(top: 2.0),
                          controller: passwordController,
                          hintText: S.of(context).old_password,
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
                        NoOutLineTextField(
                          margin: EdgeInsets.only(top: 2.0),
                          controller: newPassController,
                          hintText: S.of(context).new_password,
                          prefixIcon: UniconsLine.lock,
                          isHidden: isNewPassword,
                          suffixWidget: InkWell(
                            child: Icon(Icons.remove_red_eye_sharp),
                            onTap: () {
                              setState(() {
                                isNewPassword = !isNewPassword;
                              });
                            },
                          ),
                        ),
                        NoOutLineTextField(
                          margin: EdgeInsets.only(top: 2.0),
                          controller: confirmPassController,
                          hintText: S.of(context).confirm_password,
                          prefixIcon: UniconsLine.lock,
                          isHidden: isConfirmPassword,
                          suffixWidget: InkWell(
                            child: Icon(Icons.remove_red_eye_sharp),
                            onTap: () {
                              setState(() {
                                isConfirmPassword = !isConfirmPassword;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: offsetLg),
                    child: FullWidthButton(
                      title: S.of(context).update_profile,
                      action: () => _update(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _update() async {
    String name = nameController.text;
    if (name.isEmpty) {
      NavigatorService(context).showSnackbar(
          S.of(context).alt_error_name, _scaffoldKey,
          type: SnackBarType.ERROR);
      return;
    }
    String email = emailController.text;
    if (email.isEmpty) {
      NavigatorService(context).showSnackbar(
          S.of(context).alert_email_error, _scaffoldKey,
          type: SnackBarType.ERROR);
      return;
    }
    var param = {
      'name': name,
      'email': email,
    };
    if (isChangePass) {
      if (isCheckPassword()) {
        String oldPass = passwordController.text;
        String newPass = newPassController.text;
        param['old_password'] = oldPass;
        param['new_password'] = newPass;
      } else {
        return;
      }
    }

    FocusScope.of(context).unfocus();
    var resp = await NetworkService(context)
        .ajax('Auth', 'fitness_update', param, isProgress: true);
    if (resp['ret'] == 10000) {
      if (isChangePass || widget.data['email'] != param['email']) {
        Navigator.of(context)
            .pushReplacementNamed(Constants.route_login, arguments: 0);
      } else {
        await PrefService().setToken(resp['result']);
        NavigatorService(context).showSnackbar(resp['msg'], _scaffoldKey);
      }
    } else {
      NavigatorService(context)
          .showSnackbar(resp['msg'], _scaffoldKey, type: SnackBarType.ERROR);
    }
  }

  bool isCheckPassword() {
    String oldPass = passwordController.text;
    if (oldPass.isEmpty) {
      NavigatorService(context).showSnackbar(
          S.of(context).error_old_password, _scaffoldKey,
          type: SnackBarType.ERROR);
      return false;
    }
    String newPass = newPassController.text;
    if (newPass.length < 6) {
      NavigatorService(context).showSnackbar(
          S.of(context).error_new_password, _scaffoldKey,
          type: SnackBarType.ERROR);
      return false;
    }
    String confirmPass = confirmPassController.text;
    if (newPass != confirmPass) {
      NavigatorService(context).showSnackbar(
          S.of(context).error_not_match, _scaffoldKey,
          type: SnackBarType.ERROR);
      return false;
    }
    return true;
  }
}
