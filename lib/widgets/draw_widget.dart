import 'dart:async';
import 'dart:io';

import 'package:fitness/generated/l10n.dart';
import 'package:fitness/services/network_service.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:fitness/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawWidget extends StatefulWidget {
  final Function() onAlarm;
  final Function(String) onMyCourse;
  final Function(dynamic) onFavorite;
  final Function() onLogout;
  final Function() onPremium;
  final Function() onRate;
  final Function(dynamic) onProfile;

  const DrawWidget({
    Key key,
    this.onAlarm,
    this.onMyCourse,
    this.onFavorite,
    this.onLogout,
    this.onProfile,
    this.onRate,
    this.onPremium,
  }) : super(key: key);

  @override
  _DrawWidgetState createState() => _DrawWidgetState();
}

class _DrawWidgetState extends State<DrawWidget> {
  var userData = {};

  @override
  void initState() {
    super.initState();

    Timer.run(() {
      initData();
    });
  }

  void initData() async {
    var resp = await NetworkService(context)
        .ajax('Auth', 'fitness_profile', {}, isProgress: false);
    if (resp['ret'] == 10000) {
      userData = resp['result'];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(context),
          createDrawerBodyItem(
              icon: Icons.home_outlined,
              text: S.of(context).home,
              onTap: () => Navigator.of(context).pop()),
          createDrawerBodyItem(
              icon: Icons.blur_linear_outlined,
              text: S.of(context).my_coures,
              isBadge:
                  (userData['course_id'] != null && userData['course_id'] == 0),
              badgeText: 'NEW',
              onTap: () {
                Navigator.of(context).pop();
                if (userData['course_id'] != null &&
                    userData['course_id'] == 0) {
                  return;
                }
                widget.onMyCourse(userData['course_id'] as String);
              }),
          createDrawerBodyItem(
              icon: Icons.favorite_border,
              text: S.of(context).my_favorite,
              onTap: () {
                Navigator.of(context).pop();
                widget.onFavorite(userData);
              }),
          Divider(),
          if (Platform.isAndroid)
            createDrawerBodyItem(
                icon: Icons.alarm,
                text: S.of(context).alarms,
                onTap: () {
                  Navigator.of(context).pop();
                  widget.onAlarm();
                }),
          createDrawerBodyItem(
              icon: Icons.rate_review_outlined,
              text: S.of(context).in_app_rate,
              isBadge: false),
          createDrawerBodyItem(
              icon: Icons.insert_chart_outlined,
              text: S.of(context).analysis,
              isBadge: true),
          Divider(),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${S.of(context).app_version} 1.0.0'),
                Icon(Icons.share, color: Colors.white,),
              ],
            ),
          ),
          if (userData['type'] == 'PREMIUM')
            ListTile(
              title: Text(
                  '${S.of(context).expired_date} ${userData['expired_date'].toString().split(' ')[0]}'),
            ),
          ListTile(),
          if (userData['type'] == 'FREE')
            ListTile(
              title: FullWidthButton(
                height: 44.0,
                buttonRadius: offsetBase,
                title: S.of(context).become_premium,
                action: () async {
                  Navigator.of(context).pop();
                  widget.onPremium();
                },
              ),
            ),
          ListTile(
            title: FullWidthButton(
              height: 44.0,
              buttonRadius: offsetBase,
              color: Colors.redAccent,
              title: S.of(context).logout,
              action: () async {
                Navigator.of(context).pop();
                widget.onLogout();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget createDrawerHeader(BuildContext context) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/img_back_01.png'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Welcome to Fitness",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500))),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: offsetLg),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  widget.onProfile(userData);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(userData['name'] ?? 'Super Fitness',
                        style: GoogleFonts.montserrat(
                          fontSize: fontLg,
                          fontWeight: weightBold,
                        )),
                    SizedBox(
                      height: offsetXSm,
                    ),
                    Text(S.of(context).view_profile,
                        style: GoogleFonts.montserrat(
                          fontSize: fontXSm,
                          fontWeight: weightMedium,
                        )),
                  ],
                ),
              ),
            ),
          )
        ]));
  }

  Widget createDrawerBodyItem(
      {IconData icon,
      String text,
      GestureTapCallback onTap,
      bool isBadge = false,
      String badgeText = 'PREMIUM'}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: offsetBase),
            child: Text(text,
                style: GoogleFonts.montserrat(
                  fontSize: fontBase,
                )),
          ),
          Spacer(),
          if (isBadge)
            Container(
                margin: EdgeInsets.only(left: offsetSm),
                padding: EdgeInsets.symmetric(
                    horizontal: offsetSm, vertical: offsetXSm),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(offsetSm))),
                child: Text(badgeText,
                    style: GoogleFonts.montserrat(
                        fontSize: fontXSm,
                        color: Colors.black,
                        fontWeight: weightBold))),
        ],
      ),
      onTap: onTap,
    );
  }
}
