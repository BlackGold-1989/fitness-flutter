import 'dart:async';

import 'package:fitness/generated/l10n.dart';
import 'package:fitness/models/course.dart';
import 'package:fitness/screens/course/course_detail_screen.dart';
import 'package:fitness/screens/main/membership_screen.dart';
import 'package:fitness/services/navigator_service.dart';
import 'package:fitness/services/network_service.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:fitness/widgets/appbar_widget.dart';
import 'package:fitness/widgets/button_widget.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFavoriteScreen extends StatefulWidget {
  final dynamic userData;

  MyFavoriteScreen({Key key, this.userData}) : super(key: key);

  @override
  _MyFavoriteScreenState createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    Timer.run(() {
      _initData();
    });
  }

  _initData() async {
    courses.clear();
    setState(() {});

    var resp = await NetworkService(context)
        .ajax('Course', 'fitness_my_favorite', {}, isProgress: true);
    if (resp['ret'] == 10000) {
      for (var json in resp['result']) {
        Course model = Course.fromMap(json);
        courses.add(model);
      }
      setState(() {});
    }
  }

  Widget emptyWidget() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: offsetXLg,
          ),
          Icon(
            Icons.favorite_outline,
            size: 120.0,
          ),
          SizedBox(
            height: offsetLg,
          ),
          Text(
            S.of(context).set_favorite,
            style: GoogleFonts.montserrat(fontSize: fontMd),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppbar(
            title: S.of(context).my_favorite,
            lendingWidget: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: (courses.isEmpty)
              ? emptyWidget()
              : ListView.builder(
                  padding: EdgeInsets.symmetric(
                      vertical: offsetBase, horizontal: offsetSm),
                  itemCount: courses.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: offsetBase),
                      child: InkWell(
                        onTap: () {
                          if (widget.userData['type'] == 'FREE' &&
                              courses[i].type == 'PREMIUM') {
                            NavigatorService(context).showCustomDialog([
                              SizedBox(
                                height: offsetXLg,
                              ),
                              Text(S.of(context).purchase_course,
                                  style: GoogleFonts.montserrat(
                                      fontSize: fontBase,
                                      fontWeight: weightBold,
                                      color: Colors.black)),
                              SizedBox(
                                height: offsetXSm,
                              ),
                              Text(S.of(context).purchase_course_detail,
                                  style: GoogleFonts.montserrat(
                                      fontSize: fontBase,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black)),
                              SizedBox(
                                height: offsetSm,
                              ),
                              Text(S.of(context).alert_upgrade_member,
                                  style: GoogleFonts.montserrat(
                                      fontSize: fontMd,
                                      fontWeight: weightBold,
                                      color: Colors.black)),
                              SizedBox(
                                height: offsetBase,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: FullWidthButton(
                                      height: 44.0,
                                      title: S.of(context).later,
                                      color: Colors.redAccent,
                                      action: () => Navigator.of(context,
                                              rootNavigator: true)
                                          .pop(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: offsetBase,
                                  ),
                                  Expanded(
                                    child: FullWidthButton(
                                      height: 44.0,
                                      title: S.of(context).upgrade_now,
                                      action: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                        NavigatorService(context).pushToWidget(
                                            screen: MemberShipScreen());
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ]);
                          } else {
                            NavigatorService(context).pushToWidget(
                                screen: CourseDetailScreen(
                              course: courses[i],
                            ));
                          }
                        },
                        child: courses[i].getListWidget(
                          context,
                          favorite: () => onFavorite(courses[i]),
                        ),
                      ),
                    );
                  })),
    );
  }

  Future<void> onFavorite(Course course) async {
    var param = {
      'course': course.id,
    };

    var resp = await NetworkService(context)
        .ajax('Course', 'fitness_favorite', param, isProgress: true);
    if (resp['ret'] == 10000) {
      _initData();
    }
  }
}
