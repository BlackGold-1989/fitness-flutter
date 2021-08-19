import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/generated/l10n.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/widgets/common_widget.dart';

class Category {
  String id;
  String title;
  String description;
  String level;
  String regdate;
  String imgurl;
  String badge;
  String other;
  int count;

  Category(
      {this.id,
      this.title,
      this.description,
      this.level,
      this.regdate,
      this.imgurl,
      this.badge,
      this.count,
      this.other});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      level: map['level'] as String,
      regdate: map['regdate'] as String,
      imgurl: map['imgurl'] as String,
      badge: map['badge'] as String,
      count: map['count'] as int,
      other: map['other'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'regdate': this.regdate,
      'imgurl': this.imgurl,
      'badge': this.badge,
      'count': this.count,
      'other': this.other,
    };
  }

  Widget getWidget(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(offsetBase)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(offsetBase))),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: CustomRectClipper(),
                    child: CachedNetworkImage(
                      imageUrl: imgurl,
                      height: 120,
                      width: 144,
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
                  BadgeWidget(
                    badge: badge,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.montserrat(
                          fontSize: fontMd, fontWeight: weightSemiBold),
                    ),
                    SizedBox(
                      height: offsetXSm,
                    ),
                    Text(description,
                        style: GoogleFonts.montserrat(
                            fontSize: fontSm, fontWeight: weightMedium)),
                    SizedBox(
                      height: offsetBase,
                    ),
                    Text('$count ${S.of(context).workout_count}',
                        style: GoogleFonts.montserrat(
                            fontSize: fontSm,
                            fontWeight: weightLight,
                            color: Colors.grey)),
                  ],
                ),
              ),
              Row(
                children: [
                  for (var i = 0; i < 3; i++)
                    Icon(
                      Icons.timeline,
                      size: 18.0,
                      color: (i < int.parse(level))
                          ? Colors.greenAccent
                          : Colors.grey,
                    ),
                ],
              ),
              SizedBox(
                width: offsetBase,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCarouselWidget({Function() action}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(offsetBase)),
      ),
      child: InkWell(
        onTap: () => action(),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(offsetBase)),
          child: Stack(
            children: [
              Container(
                color: Colors.grey,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: imgurl,
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
              Container(
                height: 62.0,
                color: Colors.black.withOpacity(0.5),
                padding: EdgeInsets.symmetric(
                    horizontal: offsetBase, vertical: offsetSm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.montserrat(
                              fontSize: fontBase, fontWeight: weightSemiBold),
                        ),
                        SizedBox(
                          height: offsetXSm,
                        ),
                        Text(description,
                            style: GoogleFonts.montserrat(
                                fontSize: fontSm, fontWeight: weightLight)),
                      ],
                    ),
                    Text('$count workout(s)',
                        style: GoogleFonts.montserrat(
                          fontSize: fontSm,
                          fontWeight: weightMedium,
                          fontStyle: FontStyle.italic,
                        )),
                  ],
                ),
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
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.6, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
