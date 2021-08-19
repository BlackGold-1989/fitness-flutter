import 'dart:convert';
import 'dart:ui';

import 'package:fitness/generated/l10n.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Alarm {
  String hour;
  String min;
  String description;
  bool isChecked;
  List<bool> repeat;
  String music;

  Alarm(
      {this.hour,
      this.min,
      this.description,
      this.isChecked,
      this.repeat,
      this.music});

  factory Alarm.fromMap(Map<String, dynamic> map) {
    var repeatJson = map['repeat'];
    List<bool> vRepeat = [];
    for (var json in jsonDecode(repeatJson)) {
      bool itemRepeat = json;
      vRepeat.add(itemRepeat);
    }
    return Alarm(
      hour: map['hour'] as String,
      min: map['min'] as String,
      description: map['description'] as String,
      isChecked: map['isChecked'] == 'true',
      repeat: vRepeat,
      music: map['music'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hour': this.hour,
      'min': this.min,
      'description': this.description,
      'isChecked': this.isChecked.toString(),
      'repeat': jsonEncode(this.repeat),
      'music': this.music,
    };
  }

  String getRepeat(BuildContext context) {
    var isEveryday = true;
    var repeatDate = [];
    var constDate = [
      S.of(context).s_sunday,
      S.of(context).s_monday,
      S.of(context).s_tuesday,
      S.of(context).s_wednesday,
      S.of(context).s_thursday,
      S.of(context).s_friday,
      S.of(context).s_saturday,
    ];
    for (var i = 0; i < repeat.length; i++) {
      if (!repeat[i]) {
        isEveryday = false;
      } else {
        repeatDate.add(constDate[i]);
      }
    }
    if (isEveryday) {
      return S.of(context).everyday;
    }
    if (repeatDate.isEmpty) {
      return S.of(context).onetime;
    }
    return repeatDate.join(', ');
  }

  Widget getWidget({BuildContext context, Function() onChange}) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(offsetBase)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          padding: EdgeInsets.all(offsetBase),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(offsetBase))),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ((int.parse(hour) < 10) ? '0$hour' : hour) +
                          ' : ' +
                          ((int.parse(min) < 10) ? '0$min' : min),
                      style: GoogleFonts.montserrat(
                          fontSize: fontMd, fontWeight: weightSemiBold),
                    ),
                    SizedBox(
                      height: offsetXSm,
                    ),
                    Text(
                      getRepeat(context),
                      style: GoogleFonts.montserrat(
                          fontSize: fontSm, color: Colors.grey),
                    ),
                    SizedBox(
                      height: offsetBase,
                    ),
                    Text(
                      description,
                      style: GoogleFonts.montserrat(
                          fontSize: fontBase, fontWeight: weightLight),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CupertinoSwitch(
                    value: isChecked,
                    onChanged: (_) => onChange(),
                    trackColor: Colors.grey,
                  ),
                  SizedBox(
                    height: offsetMd,
                  ),
                  Icon(Icons.more_vert),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
