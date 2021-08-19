import 'package:fitness/generated/l10n.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/widgets/appbar_widget.dart';
import 'package:fitness/widgets/auth/choose_item_widget.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseScreen extends StatefulWidget {
  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  var langIndex = 0;
  var genderIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var langItems = [
      S.of(context).english,
      S.of(context).chinese,
      S.of(context).korean,
      S.of(context).lao,
    ];

    var genderItems = [
      S.of(context).gender_male,
      S.of(context).gender_female,
    ];

    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppbar(
          lendingWidget: InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.of(context).pop(),
          ),
          title: S.of(context).title_choose_mode,
        ),
        body: Column(
          children: [
            SizedBox(
              height: offsetMd,
            ),
            Container(
              height: 36,
              width: double.infinity,
              padding: EdgeInsets.only(left: offsetBase),
              color: Colors.white.withOpacity(0.2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).setting_lang,
                  style: GoogleFonts.montserrat(
                      fontSize: fontSm,
                      fontWeight: FontWeight.w300,
                      color: Colors.lightGreen),
                ),
              ),
            ),
            SizedBox(
              height: offsetSm,
            ),
            for (var lang in langItems)
              InkWell(
                onTap: () {
                  setState(() {
                    langIndex = langItems.indexOf(lang);
                  });
                },
                child: TextChooseWidget(
                  title: lang,
                  isChecked: langIndex == langItems.indexOf(lang),
                ),
              ),
            SizedBox(
              height: offsetMd,
            ),
            Container(
              height: 36,
              width: double.infinity,
              padding: EdgeInsets.only(left: offsetBase),
              color: Colors.white.withOpacity(0.2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).setting_gender,
                  style: GoogleFonts.montserrat(
                      fontSize: fontSm,
                      fontWeight: FontWeight.w300,
                      color: Colors.lightGreen),
                ),
              ),
            ),
            SizedBox(
              height: offsetSm,
            ),
            for (var gender in genderItems)
              InkWell(
                onTap: () {
                  setState(() {
                    genderIndex = genderItems.indexOf(gender);
                  });
                },
                child: TextChooseWidget(
                  title: gender,
                  isChecked: genderIndex == genderItems.indexOf(gender),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
