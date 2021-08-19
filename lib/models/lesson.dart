import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:fitness/generated/l10n.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class Lesson {
  String id;
  String course_id;
  String course_index;
  String description;
  String type;
  String link;
  String during;
  String multiple;
  String regdate;
  String other;

  Lesson(
      {this.id,
      this.course_id,
      this.course_index,
      this.description,
      this.type,
      this.link,
      this.during,
      this.multiple,
      this.regdate,
      this.other});

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return new Lesson(
      id: map['id'] as String,
      course_id: map['course_id'] as String,
      course_index: map['course_index'] as String,
      description: map['description'] as String,
      type: map['type'] as String,
      link: map['link'] as String,
      during: map['during'] as String,
      multiple: map['multiple'] as String,
      regdate: map['regdate'] as String,
      other: map['other'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'course_id': this.course_id,
      'course_index': this.course_index,
      'description': this.description,
      'type': this.type,
      'link': this.link,
      'during': this.during,
      'multiple': this.multiple,
      'regdate': this.regdate,
      'other': this.other,
    };
  }

  Widget getGridItem(BuildContext context, {int step = 0, int index = 0}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(offsetBase)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(offsetBase)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Container(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: CustomRectClipper(),
                          child: FutureBuilder<Uint8List>(
                            future: getThumbnail(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Image.memory(
                                  snapshot.data,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Icon(
                                    Icons.error_outline,
                                    size: 48.0,
                                  ),
                                );
                              } else {
                                return Container(
                                    color: Colors.grey,
                                    child: Center(
                                        child: CupertinoActivityIndicator(
                                      radius: 24.0,
                                    )));
                              }
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: offsetSm, bottom: offsetXSm),
                            child: Icon(
                              Icons.videocam,
                              size: 28.0,
                            ),
                          ),
                        ),
                        if (step > -1)
                          Container(
                            margin: EdgeInsets.all(offsetSm),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(offsetBase)),
                            ),
                            child: Icon(
                              Icons.circle,
                              color: step == (index + 1)
                                  ? Colors.yellow
                                  : step > (index + 1)
                                      ? Colors.green
                                      : Colors.red,
                              size: 18.0,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '$course_index ${S.of(context).lesson}',
                            style: GoogleFonts.montserrat(
                                fontSize: fontMd, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(height: offsetSm,),
                      Text(
                        '$description',
                        style: GoogleFonts.montserrat(
                            fontSize: fontXSm, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Uint8List> getThumbnail() async {
    return await VideoThumbnail.thumbnailData(
      video: link,
      imageFormat: ImageFormat.PNG,
      maxWidth: 256,
      // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
  }
}

class CustomRectClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
