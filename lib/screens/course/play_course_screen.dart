import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:fitness/generated/l10n.dart';
import 'package:fitness/models/lesson.dart';
import 'package:fitness/screens/course/finish_course_screen.dart';
import 'package:fitness/services/navigator_service.dart';
import 'package:fitness/services/network_service.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:fitness/widgets/appbar_widget.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:fitness/widgets/down_counter_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class PlayCourseScreen extends StatefulWidget {
  final List<Lesson> lessons;
  final int leftCourse;
  final String courseID;

  const PlayCourseScreen(
      {Key key, this.lessons, this.leftCourse, this.courseID})
      : super(key: key);

  @override
  _PlayCourseScreenState createState() => _PlayCourseScreenState();
}

class _PlayCourseScreenState extends State<PlayCourseScreen> {
  var lessonIndex = 0;
  var imageUrl = '';

  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    initMedia();
  }

  void initMedia() async {
    setState(() {});

    // if (videoPlayerController != null) videoPlayerController.dispose();
    // if (chewieController != null) chewieController.dispose();
    if (widget.lessons[lessonIndex].type == 'VIDEO') {
      videoPlayerController =
          VideoPlayerController.network(widget.lessons[lessonIndex].link);
      await Future.wait([videoPlayerController.initialize()]);
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
      );
    } else {
      imageUrl = widget.lessons[lessonIndex].link;
    }

    setState(() {});
  }

  @override
  void dispose() {
    if (videoPlayerController != null) videoPlayerController.dispose();
    if (chewieController != null) chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppbar(
          lendingWidget: InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.of(context).pop(),
          ),
          title: S.of(context).lesson + ' ${lessonIndex + 1}',
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: offsetXSm),
              child: Row(
                children: [
                  for (var i = 0; i < widget.lessons.length; i++)
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Container(
                        height: 4,
                        color: i > lessonIndex ? Colors.grey : Colors.white,
                      ),
                    ))
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: offsetSm, vertical: offsetSm),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(offsetBase)),
                        child: Container(
                          width: double.infinity,
                          height: screenWidth / 1.6,
                          color: Colors.white.withOpacity(0.1),
                          child: widget.lessons[lessonIndex].type == 'VIDEO'
                              // ? VideoWidget(
                              //     videoUrl: widget.lessons[lessonIndex].link)
                              ? videoWidget()
                              : imageWidget(),
                        ),
                      ),
                      SizedBox(
                        height: offsetBase,
                      ),
                      BlurWidget(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${S.of(context).lesson_during} : ${widget.lessons[lessonIndex].during}s',
                              style: GoogleFonts.montserrat(
                                  fontSize: fontBase, fontWeight: weightBold),
                            ),
                            if (widget.lessons[lessonIndex].type == 'VIDEO')
                              Column(
                                children: [
                                  SizedBox(
                                    height: offsetSm,
                                  ),
                                  Text(
                                    'Please follow the current video',
                                    style: GoogleFonts.montserrat(
                                        fontSize: fontBase,
                                        fontWeight: weightMedium),
                                  ),
                                ],
                              ),
                            SizedBox(
                              height: offsetSm,
                            ),
                            Text(
                              widget.lessons[lessonIndex].description,
                              style: GoogleFonts.montserrat(
                                  fontSize: fontBase, fontWeight: weightMedium),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: offsetLg,
                      ),
                      DownCounterWidget(
                        lessons: widget.lessons,
                        onNext: (index) {
                          if (index < widget.lessons.length) {
                            lessonIndex = index;
                            initMedia();
                          }
                        },
                        onFinish: () async {
                          var isPremium = false;
                          var resp = await NetworkService(context).ajax(
                              'Auth', 'fitness_premium', {},
                              isProgress: true);
                          if (resp['ret'] == 10000) {
                            isPremium = resp['result']['premium'] == 'PREMIUM';
                            NavigatorService(context).pushToWidget(
                                screen: FinishCourseScreen(
                                  courseID: widget.courseID,
                                  leftDays: widget.leftCourse,
                                  isPremium: isPremium,
                                ),
                                replace: true);
                          }
                        },
                      ),
                      SizedBox(
                        height: offsetLg,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget videoWidget() {
    return chewieController != null &&
            chewieController.videoPlayerController.value.isInitialized
        ? Chewie(
            controller: chewieController,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading'),
            ],
          );
  }

  Widget imageWidget() {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: 144.0,
      height: 120.0,
      placeholder: (context, url) => Padding(
        padding: const EdgeInsets.all(offsetBase),
        child: Stack(
          children: [
            Center(
                child: Image.asset(
              'assets/icons/ic_logo.png',
              width: 120.0,
              height: 120.0,
            )),
            CupertinoActivityIndicator(),
          ],
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
