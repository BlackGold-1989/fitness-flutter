import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/generated/l10n.dart';
import 'package:fitness/models/category.dart';
import 'package:fitness/models/course.dart';
import 'package:fitness/screens/course/course_detail_screen.dart';
import 'package:fitness/screens/main/membership_screen.dart';
import 'package:fitness/services/navigator_service.dart';
import 'package:fitness/services/network_service.dart';
import 'package:fitness/services/string_service.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:fitness/widgets/appbar_widget.dart';
import 'package:fitness/widgets/button_widget.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  const CategoryScreen({Key key, @required this.category}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Course> courses = [];
  var favCount = 0;

  @override
  void initState() {
    super.initState();
    Timer.run(() {
      initData();
    });
  }

  void initData() async {
    courses.clear();
    setState(() {});
    var param = {
      'category_id': widget.category.id,
    };

    var resp = await NetworkService(context)
        .ajax('Course', 'fitness_course', param, isProgress: true);
    if (resp['ret'] == 10000) {
      for (var json in resp['result']['course']) {
        Course model = Course.fromMap(json);
        courses.add(model);
      }
      favCount = resp['result']['category_fav'];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return BackgroundWidget(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: CustomAppbar(
          lendingWidget: InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.of(context).pop(),
          ),
          title: widget.category.title,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: offsetXSm,
              ),
              Container(
                height: 2,
                color: Colors.white,
              ),
              Stack(
                children: [
                  Hero(
                    tag: 'category${widget.category.id})',
                    child: CachedNetworkImage(
                      imageUrl: widget.category.imgurl,
                      height: screenWidth / 1.6,
                      width: screenWidth,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(offsetBase),
                        child: Stack(
                          children: [
                            Center(
                                child: Image.asset(
                              'assets/icons/ic_logo.png',
                              width: 60.0,
                              height: 60.0,
                            )),
                            CupertinoActivityIndicator(),
                          ],
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: (screenWidth / 1.6 - 80)),
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      color: Colors.black.withOpacity(0.75),
                      padding: EdgeInsets.symmetric(
                          horizontal: offsetBase, vertical: offsetSm),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.category.description,
                                    style: GoogleFonts.montserrat(
                                        fontSize: fontMd,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                  widget.category.other,
                                  style: GoogleFonts.montserrat(
                                      fontSize: fontBase,
                                      fontWeight: FontWeight.w300),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: offsetBase,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.favorite_border),
                              SizedBox(
                                height: offsetXSm,
                              ),
                              Text(
                                StringService.getFavCount(favCount),
                                style: GoogleFonts.montserrat(fontSize: fontSm),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 2,
                color: Colors.white,
              ),
              SizedBox(
                height: offsetBase,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: offsetSm),
                child: Column(
                  children: [
                    for (var course in courses)
                      Padding(
                        padding: const EdgeInsets.only(bottom: offsetSm),
                        child: InkWell(
                            onTap: () async {
                              var resp = await NetworkService(context).ajax(
                                  'Auth', 'fitness_profile', {},
                                  isProgress: false);
                              if (resp['ret'] == 10000) {
                                var userData = resp['result'];
                                if (userData['type'] == 'FREE' &&
                                    course.type == 'PREMIUM') {
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
                                              NavigatorService(context)
                                                  .pushToWidget(
                                                      screen:
                                                          MemberShipScreen());
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]);
                                } else {
                                  NavigatorService(context).pushToWidget(
                                      screen: CourseDetailScreen(
                                    course: course,
                                  ));
                                }
                              }
                            },
                            child: course.getListWidget(context,
                                favorite: () => onFavorite(course))),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onFavorite(Course course) async {
    var param = {
      'course': course.id,
    };

    var resp = await NetworkService(context)
        .ajax('Course', 'fitness_favorite', param, isProgress: true);
    if (resp['ret'] == 10000) {
      var isFavorite = resp['result']['isfavorite'];
      course.isfavorite = isFavorite;
      if (isFavorite) {
        favCount = favCount + 1;
      } else {
        favCount = favCount - 1;
      }
      setState(() {});
    }
  }
}
