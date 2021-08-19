import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Gym {
  String id;
  String title;
  String detail;
  String imgurl;
  String other;

  Gym({
    this.id,
    this.title,
    this.detail,
    this.imgurl,
    this.other,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
      'imgurl': imgurl,
      'other': other,
    };
  }

  factory Gym.fromMap(Map<String, dynamic> map) {
    return Gym(
      id: map['id'] as String,
      title: map['title'] as String,
      detail: map['detail'] as String,
      imgurl: map['imgurl'] as String,
      other: map['other'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Gym.fromJson(String source) => Gym.fromMap(json.decode(source));

  Widget getListItem(BuildContext context, {bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: offsetSm),
      child: Row(
        children: [
          Container(
            child: CachedNetworkImage(
              imageUrl: imgurl,
              fit: BoxFit.contain,
              width: 60.0,
              height: 60.0,
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
          SizedBox(
            width: offsetBase,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.montserrat(
                        fontSize: fontBase, fontWeight: weightSemiBold)),
                SizedBox(
                  height: offsetXSm / 2,
                ),
                Text(detail,
                    style: GoogleFonts.montserrat(
                        fontSize: fontSm, fontWeight: weightLight)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
