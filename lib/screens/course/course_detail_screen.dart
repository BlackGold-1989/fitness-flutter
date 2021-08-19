import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/generated/l10n.dart';
import 'package:fitness/models/course.dart';
import 'package:fitness/models/gym.dart';
import 'package:fitness/models/lesson.dart';
import 'package:fitness/screens/course/play_course_screen.dart';
import 'package:fitness/services/navigator_service.dart';
import 'package:fitness/services/network_service.dart';
import 'package:fitness/services/string_service.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:fitness/widgets/appbar_widget.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;

  const CourseDetailScreen({Key key, this.course}) : super(key: key);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  var courseStep = '0';
  var courseStatus = 0;
  var during = '0';

  List<Lesson> lessons = [];
  List<Gym> gyms = [];

  @override
  void initState() {
    super.initState();

    Timer.run(() {
      initData();
    });
  }

  void initData() async {
    lessons.clear();
    gyms.clear();
    setState(() {});
    var param = {
      'course': widget.course.id,
    };

    var resp = await NetworkService(context)
        .ajax('Course', 'fitness_lesson', param, isProgress: true);
    if (resp['ret'] == 10000) {
      var duringTime = 0;
      for (var json in resp['result']['lesson']) {
        Lesson model = Lesson.fromMap(json);
        lessons.add(model);
        duringTime = duringTime + int.parse(model.during);
      }

      for (var json in resp['result']['gym']) {
        Gym model = Gym.fromMap(json);
        gyms.add(model);
      }

      during = '$duringTime';
      var courseID = resp['result']['user_course']['course_id'];
      if (courseID == widget.course.id) {
        courseStatus = 0;
      } else if (courseID == '0') {
        courseStatus = 1;
      } else {
        courseStatus = 2;
      }
      courseStep = resp['result']['user_course']['course_step'];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return BackgroundWidget(
      isBlur: false,
      backImage: 'assets/images/img_back_02.png',
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppbar(
          lendingWidget: InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.of(context).pop(),
          ),
          title: widget.course.title ??'My Course',
          actions: [
            courseStatus == 0
                ? IconButton(icon: Icon(Icons.bar_chart), onPressed: () {})
                : IconButton(icon: Icon(Icons.help_outline), onPressed: () {}),
          ],
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
              Container(
                height: screenWidth / 1.6,
                width: screenWidth,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.course.imgurl,
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 80,
                        color: Colors.black.withOpacity(0.5),
                        padding: EdgeInsets.symmetric(
                            horizontal: offsetBase, vertical: offsetSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.course.title,
                                style: GoogleFonts.montserrat(
                                    fontSize: fontLg, fontWeight: weightBold),
                              ),
                            ),
                            SizedBox(
                              width: offsetSm,
                            ),
                            if (courseStatus != 2)
                              InkWell(
                                onTap: () =>
                                    NavigatorService(context).pushToWidget(
                                        screen: PlayCourseScreen(
                                  courseID: widget.course.id,
                                  leftCourse:
                                      int.parse(widget.course.repeat_time) -
                                          int.parse(courseStep) -
                                          1,
                                  lessons: lessons,
                                )),
                                child: Container(
                                  width: 100,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(offsetSm))),
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        courseStatus == 0
                                            ? Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    '$courseStep',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: fontMd,
                                                            fontWeight:
                                                                weightBold),
                                                  ),
                                                  Text(
                                                    S.of(context).course_day,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: fontXSm),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                S.of(context).start,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: fontBase,
                                                    fontWeight: weightBold),
                                              ),
                                        SizedBox(
                                          width: offsetXSm,
                                        ),
                                        Icon(Icons.arrow_right_alt)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(offsetBase),
                      child: Icon(
                        widget.course.isfavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 48.0,
                        color: widget.course.isfavorite
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 2,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: offsetSm, vertical: offsetBase),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).course_detail,
                        style: GoogleFonts.montserrat(
                            fontSize: fontBase, fontWeight: weightSemiBold)),
                    SizedBox(
                      height: offsetSm,
                    ),
                    BlurWidget(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.course.detail,
                            style: GoogleFonts.montserrat(
                                fontSize: fontBase, fontWeight: weightMedium),
                          ),
                          SizedBox(
                            height: offsetBase,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${S.of(context).course_count}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: fontBase,
                                  )),
                              Text('${lessons.length} flows',
                                  style: GoogleFonts.montserrat(
                                      fontSize: fontMd,
                                      fontWeight: weightSemiBold)),
                            ],
                          ),
                          SizedBox(
                            height: offsetBase,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${S.of(context).course_during}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: fontBase,
                                  )),
                              Text('${StringService.getTimeByString(during)}',
                                  style: GoogleFonts.montserrat(
                                      fontSize: fontMd,
                                      fontWeight: weightSemiBold)),
                            ],
                          ),
                          SizedBox(
                            height: offsetBase,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${S.of(context).repeat_time}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: fontBase,
                                  )),
                              Text('${widget.course.repeat_time} Day(s)',
                                  style: GoogleFonts.montserrat(
                                      fontSize: fontMd,
                                      fontWeight: weightSemiBold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: offsetBase,
                    ),
                    Text(
                      S.of(context).course_gyms,
                      style: GoogleFonts.montserrat(
                          fontSize: fontBase, fontWeight: weightSemiBold),
                    ),
                    SizedBox(
                      height: fontSm,
                    ),
                    BlurWidget(
                        child: Column(
                      children: [
                        for (var gym in gyms)
                          gym.getListItem(context, isLast: gyms.last == gym),
                      ],
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: offsetBase,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
