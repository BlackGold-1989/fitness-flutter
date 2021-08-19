import 'package:fitness/generated/l10n.dart';
import 'package:fitness/services/network_service.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:fitness/utils/constants.dart';
import 'package:fitness/widgets/button_widget.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:fitness/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class FinishCourseScreen extends StatefulWidget {
  final bool isPremium;
  final int leftDays;
  final String courseID;

  const FinishCourseScreen(
      {Key key, this.isPremium = false, this.leftDays, this.courseID})
      : super(key: key);

  @override
  _FinishCourseScreenState createState() => _FinishCourseScreenState();
}

class _FinishCourseScreenState extends State<FinishCourseScreen> {
  var bodyController = TextEditingController();
  var lengthController = TextEditingController();
  var heartController = TextEditingController();

  @override
  void dispose() {
    bodyController.dispose();
    lengthController.dispose();
    heartController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 0,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: offsetBase, vertical: offsetBase),
              child: Column(
                children: [
                  SizedBox(height: offsetLg),
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius:
                          BorderRadius.all(Radius.circular(120.0 / 2.0)),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        size: 90.0,
                      ),
                    ),
                  ),
                  SizedBox(height: offsetLg),
                  Text(
                    S.of(context).title_finish_course,
                    style: GoogleFonts.montserrat(
                        fontSize: fontXLg, fontWeight: weightBold),
                  ),
                  SizedBox(height: offsetBase),
                  Text(
                    S.of(context).desc_finish_course +
                        '${widget.leftDays} Day(s)',
                    style: GoogleFonts.montserrat(
                        fontSize: fontBase, fontWeight: weightMedium),
                    textAlign: TextAlign.center,
                  ),
                  if (widget.isPremium)
                    Column(
                      children: [
                        SizedBox(
                          height: offsetXLg,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_crown.svg',
                              color: Colors.orange,
                            ),
                            SizedBox(
                              width: offsetBase,
                            ),
                            Text(
                              S.of(context).premium_member,
                              style: GoogleFonts.montserrat(
                                  fontSize: fontMd, fontWeight: weightSemiBold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: offsetBase,
                        ),
                        NoOutLineTextField(
                          controller: bodyController,
                          hintText: S.of(context).body_weight,
                          prefixIcon: UniconsLine.weight,
                          suffixWidget: Center(
                            child: Text('Kg',
                                style:
                                    GoogleFonts.montserrat(fontSize: fontBase)),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: offsetXSm,
                        ),
                        NoOutLineTextField(
                          controller: lengthController,
                          hintText: S.of(context).waist_measure,
                          prefixIcon: UniconsLine.ruler,
                          suffixWidget: Center(
                            child: Text('Cm',
                                style:
                                    GoogleFonts.montserrat(fontSize: fontBase)),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: offsetXSm,
                        ),
                        NoOutLineTextField(
                          controller: heartController,
                          hintText: S.of(context).heart_rate,
                          prefixIcon: UniconsLine.heart,
                          suffixWidget: Center(
                            child: Text('npm',
                                style:
                                    GoogleFonts.montserrat(fontSize: fontBase)),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  SizedBox(height: offsetXLg),
                  FullWidthButton(
                    title: S.of(context).goto_course,
                    action: () => updateCourseInfo(),
                  ),
                  SizedBox(
                    height: offsetMd,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateCourseInfo() async {
    var param = {
      'leftdays': '${widget.leftDays}',
      'courseid': '${widget.courseID}',
    };
    if (widget.isPremium) {
      param['body'] = bodyController.text;
      param['length'] = lengthController.text;
      param['heart'] = heartController.text;
    }
    var resp = await NetworkService(context)
        .ajax('Course', 'fitness_user_course', param, isProgress: true);
    if (resp['ret'] == 10000) {
      Navigator.popUntil(context, ModalRoute.withName(Constants.route_main));
    }
  }
}
