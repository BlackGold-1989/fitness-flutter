import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitness/generated/l10n.dart';
import 'package:fitness/models/category.dart';
import 'package:fitness/models/course.dart';
import 'package:fitness/screens/course/course_detail_screen.dart';
import 'package:fitness/screens/main/alarm_screen.dart';
import 'package:fitness/screens/main/category_screen.dart';
import 'package:fitness/screens/main/membership_screen.dart';
import 'package:fitness/screens/main/my_favorite_screen.dart';
import 'package:fitness/screens/main/profile_screen.dart';
import 'package:fitness/services/navigator_service.dart';
import 'package:fitness/services/network_service.dart';
import 'package:fitness/services/pref_service.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/utils/constants.dart';
import 'package:fitness/widgets/appbar_widget.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:fitness/widgets/draw_widget.dart';
import 'package:fitness/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Category> categories = [];
  List<Category> hotCategories = [];
  List<Category> newCategories = [];
  Course currentCourse;

  final InAppReview inAppReview = InAppReview.instance;


  @override
  void initState() {
    super.initState();

    Timer.run(() {
      initData();
    });
  }

  void initData() async {
    categories.clear();
    hotCategories.clear();
    newCategories.clear();
    setState(() {});

    var resp = await NetworkService(context)
        .ajax('Course', 'fitness_category', Map(), isProgress: true);
    if (resp['ret'] == 10000) {
      for (var json in resp['result']['category']) {
        Category model = Category.fromMap(json);
        categories.add(model);
        if (model.badge == 'HOT') {
          hotCategories.add(model);
        }
        if (model.badge == 'NEW') {
          newCategories.add(model);
        }
      }

      if (resp['result']['course'] != null) {
        currentCourse = Course.fromMap(resp['result']['course']);
      }

      setState(() {});
    }
  }

  void addRate() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      isBlur: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppbar(
          title: S.of(context).app_name,
          actions: [
            if (Platform.isAndroid)
              IconButton(
                  icon: Icon(Icons.alarm),
                  onPressed: () => NavigatorService(context).pushToWidget(
                      screen: AlarmScreen(),
                      pop: (_) {
                        initData();
                      })),
          ],
        ),
        drawer: DrawWidget(
          onAlarm: () =>
              NavigatorService(context).pushToWidget(screen: AlarmScreen()),
          onMyCourse: (courseId) async {
            if (currentCourse == null) {

              return;
            }
            NavigatorService(context).pushToWidget(
                screen: CourseDetailScreen(
              course: currentCourse,
            ));
          },
          onFavorite: (userData) => NavigatorService(context).pushToWidget(
              screen: MyFavoriteScreen(
            userData: userData,
          )),
          onLogout: () async {
            await PrefService().logout();
            Navigator.of(context)
                .pushReplacementNamed(Constants.route_login, arguments: 0);
          },
          onProfile: (data) => NavigatorService(context).pushToWidget(
              screen: ProfileScreen(
            data: data,
          )),
          onPremium: () => NavigatorService(context)
              .pushToWidget(screen: MemberShipScreen()),
          onRate: () => addRate(),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: offsetBase, horizontal: offsetSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).current_course,
                      style: GoogleFonts.montserrat(
                          fontSize: fontBase, color: Colors.grey),
                    ),
                    StrokeText(
                      title: S.of(context).view_all_history,
                      textStyle: GoogleFonts.montserrat(
                          fontSize: fontSm, color: Colors.black),
                      strokeColor: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: offsetBase,
                ),
                currentCourse == null
                    ? Course.emptyWidget(context)
                    : InkWell(
                        child: currentCourse.getListWidget(context),
                        onTap: () {
                          NavigatorService(context).pushToWidget(
                              screen: CourseDetailScreen(
                            course: currentCourse,
                          ));
                        },
                      ),
                if (hotCategories.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: offsetLg,
                      ),
                      Row(
                        children: [
                          BadgeWidget(
                            badge: 'HOT',
                          ),
                          SizedBox(
                            width: offsetSm,
                          ),
                          Text(
                            S.of(context).hot_category +
                                ' (${hotCategories.length})',
                            style: GoogleFonts.montserrat(
                                fontSize: fontBase, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: offsetBase,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            viewportFraction: 0.8,
                            height: (MediaQuery.of(context).size.width -
                                    offsetBase * 2) /
                                1.6),
                        items: [
                          for (var item in hotCategories)
                            item.getCarouselWidget(
                              action: () =>
                                  NavigatorService(context).pushToWidget(
                                      screen: CategoryScreen(
                                category: item,
                              )),
                            ),
                        ],
                      ),
                    ],
                  ),
                SizedBox(
                  height: offsetLg,
                ),
                Text(
                  S.of(context).all_category + ' (${categories.length})',
                  style: GoogleFonts.montserrat(
                      fontSize: fontBase, color: Colors.grey),
                ),
                SizedBox(
                  height: offsetBase,
                ),
                for (var category in categories)
                  AnimatedListItem(categories.indexOf(category),
                      child: InkWell(
                        child: category.getWidget(context),
                        onTap: () => NavigatorService(context).pushToWidget(
                            screen: CategoryScreen(
                          category: category,
                        )),
                      )),
                SizedBox(
                  height: offsetLg,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
