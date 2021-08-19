import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:fitness/generated/l10n.dart';
import 'package:fitness/screens/auth/choose_screen.dart';
import 'package:fitness/screens/auth/register_screen.dart';
import 'package:fitness/screens/auth/verify_screen.dart';
import 'package:fitness/services/common_service.dart';
import 'package:fitness/services/navigator_service.dart';
import 'package:fitness/services/network_service.dart';
import 'package:fitness/services/pref_service.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:fitness/utils/constants.dart';
import 'package:fitness/widgets/button_widget.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:fitness/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:unicons/unicons.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var isPassword = true;
  var isRemember = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    initData();
  }

  void initData() async {
    String email = await PrefService().getEmail();
    String password = await PrefService().getPassword();
    setState(() {
      emailController.text = email;
      passController.text = password;
    });
  }

  void _onLoginGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    var account = await _googleSignIn.signIn();
    if (account != null) {
      var param = {
        'email': account.email,
        'type': 'GOOGLE',
        'name': account.displayName,
      };

      _socialLogin(param);
    }
  }

  void _onLoginApple() async {
    if (Platform.isAndroid) {
      String redirectionUri =
          'https://fitness.laodev.info/Auth/fitness_apple';
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: 'example-nonce',
        state: 'example-state',
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'profitness2021',
          redirectUri: Uri.parse(
            redirectionUri,
          ),
        ),
      );
      try {
        Map<String, dynamic> payload = Jwt.parseJwt(credential.identityToken);
        String email = payload['email'] as String;
        var param = {
          'email': email,
          'type': 'APPLE',
          'name': email.split('@').first,
        };
        _socialLogin(param);
      } catch (e) {
        NavigatorService(context).showSnackbar(S.of(context).error_google_sign, _scaffoldKey,
            type: SnackBarType.ERROR);
      }
    } else {
      var resp = await CommonService.initAppleSign();
      if (resp == "Not found any auth") {
        NavigatorService(context).showSnackbar(S.of(context).error_google_sign, _scaffoldKey,
            type: SnackBarType.ERROR);
        return;
      }

      Map<String, dynamic> payload = Jwt.parseJwt(resp);
      print('[APPLE] sign: ${jsonEncode(payload)}');
      String email = payload['email'] as String;

      var param = {
        'email': email,
        'type': 'APPLE',
        'name': email.split('@').first,
      };
      _socialLogin(param);
    }
  }

  void _socialLogin(param) async {
    var resp = await NetworkService(context)
        .ajax('Auth', 'fitness_social_login', param, isProgress: true);
    if (resp['ret'] == 10000) {
      var token = resp['result']['token'];
      await PrefService().setToken(token);
      Navigator.of(context).pushNamed(Constants.route_main, arguments: 0);
    } else {
      NavigatorService(context).showSnackbar(S.of(context).error_google_sign, _scaffoldKey,
          type: SnackBarType.ERROR);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
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
                Row(
                  children: [
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        UniconsLine.setting,
                        size: 32.0,
                      ),
                      onPressed: () {
                        NavigatorService(context)
                            .pushToWidget(screen: ChooseScreen());
                      },
                    )
                  ],
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: 120.0,
                ),
                SizedBox(
                  height: offsetXLg,
                ),
                Text(
                  S.of(context).content_welcome,
                  style: GoogleFonts.montserrat(
                      fontSize: fontLg, fontWeight: weightBold),
                ),
                SizedBox(
                  height: offsetXLg,
                ),
                NoOutLineTextField(
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
                  padding: const EdgeInsets.symmetric(vertical: offsetBase),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isRemember = !isRemember;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(isRemember
                            ? Icons.check_box
                            : Icons.check_box_outline_blank),
                        SizedBox(
                          width: offsetSm,
                        ),
                        Text(S.of(context).remember_me,
                            style: GoogleFonts.montserrat(
                                fontSize: fontSm, fontWeight: weightMedium)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: offsetBase),
                  child: FullWidthButton(
                    title: S.of(context).signin,
                    action: () => _login(),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlineEmptyButton(
                        titleWidget: Row(
                          children: [
                            Spacer(),
                            Icon(UniconsLine.apple),
                            SizedBox(
                              width: offsetSm,
                            ),
                            Text(
                              S.of(context).apple,
                              style: GoogleFonts.montserrat(
                                  fontSize: fontBase,
                                  fontWeight: weightSemiBold),
                            ),
                            Spacer(),
                          ],
                        ),
                        onPress: () => _onLoginApple(),
                      ),
                    ),
                    SizedBox(
                      width: offsetSm,
                    ),
                    Expanded(
                      child: OutlineEmptyButton(
                        titleWidget: Row(
                          children: [
                            Spacer(),
                            Icon(UniconsLine.google),
                            SizedBox(
                              width: offsetSm,
                            ),
                            Text(
                              S.of(context).google,
                              style: GoogleFonts.montserrat(
                                  fontSize: fontBase,
                                  fontWeight: weightSemiBold),
                            ),
                            Spacer(),
                          ],
                        ),
                        onPress: () => _onLoginGoogle(),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  S.of(context).no_register,
                  style: GoogleFonts.montserrat(
                      fontSize: fontSm, fontWeight: weightMedium),
                ),
                SizedBox(
                  height: offsetSm,
                ),
                OutlineEmptyButton(
                  title: S.of(context).create_account,
                  onPress: () => NavigatorService(context).pushToWidget(
                      screen: RegisterScreen(),
                      pop: (value) {
                        if (value != null) {
                          NavigatorService(context).showSnackbar(
                            value,
                            _scaffoldKey,
                          );
                        }
                      }),
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

  void _login() async {
    var email = emailController.text;
    if (email.isEmpty || !email.contains('@')) {
      NavigatorService(context).showSnackbar(
          S.of(context).alert_email_error, _scaffoldKey,
          type: SnackBarType.ERROR);
      return;
    }
    var password = passController.text;
    if (password.isEmpty) {
      NavigatorService(context).showSnackbar(
          S.of(context).alert_password_error, _scaffoldKey,
          type: SnackBarType.ERROR);
      return;
    }

    FocusScope.of(context).unfocus();
    var param = {'email': email.toString(), 'password': password.toString()};
    var resp = await NetworkService(context)
        .ajax('Auth', 'fitness_login', param, isProgress: true);
    if (resp['ret'] == 10000) {
      if (isRemember) {
        await PrefService().setEmail(email);
        await PrefService().setPassword(password);
      }
      var isVerify = resp['result']['isverify'];
      if (isVerify) {
        NavigatorService(context)
            .pushToWidget(screen: VerifyScreen(email: email));
      } else {
        var token = resp['result']['token'];
        await PrefService().setToken(token);
        Navigator.of(context).pushNamed(Constants.route_main, arguments: 0);
      }
    } else {
      NavigatorService(context)
          .showSnackbar(resp['result'], _scaffoldKey, type: SnackBarType.ERROR);
    }
  }
}
