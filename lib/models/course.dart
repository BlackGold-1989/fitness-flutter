import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/generated/l10n.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Course {
  String id;
  String category_id;
  String title;
  String detail;
  String imgurl;
  String badge;
  String ran;
  String type;
  String repeat_time;
  String regdate;
  String other;

  bool isfavorite;
  int lessons;

  Course(
      {this.id,
      this.category_id,
      this.title,
      this.detail,
      this.imgurl,
      this.badge,
      this.ran,
      this.type,
      this.repeat_time,
      this.regdate,
      this.isfavorite = false,
      this.lessons,
      this.other});

  factory Course.fromMap(Map<String, dynamic> map) {
    return new Course(
      id: map['id'] as String,
      category_id: map['category_id'] as String,
      title: map['title'] as String,
      detail: map['detail'] as String,
      imgurl: map['imgurl'] as String,
      badge: map['badge'] as String,
      ran: map['ran'] as String,
      type: map['type'] as String,
      repeat_time: map['repeat_time'] as String,
      regdate: map['regdate'] as String,
      lessons: map['lessons'] as int,
      isfavorite: map['isfavorite'] as bool ?? false,
      other: map['other'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'category_id': this.category_id,
      'title': this.title,
      'detail': this.detail,
      'imgurl': this.imgurl,
      'badge': this.badge,
      'ran': this.ran,
      'type': this.type,
      'repeat_time': this.repeat_time,
      'regdate': this.regdate,
      'lessons': this.lessons,
      'isfavorite': this.isfavorite,
      'other': this.other,
    };
  }

  Widget getListWidget(BuildContext context, {Function() favorite}) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(offsetBase)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: Colors.white.withOpacity(0.2),
          child: Row(
            children: [
              Container(
                width: 144.0,
                height: 120.0,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: CustomRectClipper(),
                      child: Container(
                        color: Colors.grey,
                        child: CachedNetworkImage(
                          imageUrl: imgurl,
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
                                  width: 60.0,
                                  height: 60.0,
                                )),
                                CupertinoActivityIndicator(),
                              ],
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () => favorite(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: offsetBase, vertical: offsetXSm),
                          child: Icon(
                            isfavorite ? Icons.favorite : Icons.favorite_border,
                            size: 28.0,
                            color: isfavorite ? Colors.red : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    BadgeWidget(
                      badge: badge,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                        fontSize: fontMd, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: offsetSm,
                  ),
                  Text(
                    detail,
                    style: GoogleFonts.montserrat(
                        fontSize: fontXSm,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic),
                    maxLines: 3,
                  ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: offsetBase),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$lessons',
                      style: GoogleFonts.montserrat(
                          fontSize: fontMd, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      S.of(context).lesson_count,
                      style: GoogleFonts.montserrat(fontSize: fontXSm),
                    ),
                    if (type != 'FREE')
                      Column(
                        children: [
                          SizedBox(
                            height: offsetSm,
                          ),
                          SvgPicture.asset(
                            'assets/icons/ic_crown.svg',
                            color: Colors.orangeAccent,
                            height: 36.0,
                          ),
                        ],
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

  static Widget emptyWidget(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(offsetBase)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: Colors.white.withOpacity(0.2),
          child: Row(
            children: [
              ClipPath(
                clipper: CustomRectClipper(),
                child: Container(
                  color: Colors.black54,
                  width: 144.0,
                  height: 120.0,
                  child: Center(
                    child: Image.asset(
                      'assets/icons/ic_logo.png',
                      width: 90.0,
                      height: 90.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Text(
                S.of(context).lesson_empty,
                style: GoogleFonts.montserrat(
                    fontSize: fontBase, fontWeight: FontWeight.w400),
              )),
              SizedBox(
                width: offsetBase,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRectClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width * 0.6, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
