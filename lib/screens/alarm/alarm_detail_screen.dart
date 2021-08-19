import 'package:fitness/generated/l10n.dart';
import 'package:fitness/models/alarm.dart';
import 'package:fitness/services/navigator_service.dart';
import 'package:fitness/services/pref_service.dart';
import 'package:fitness/services/string_service.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/themes/textstyle.dart';
import 'package:fitness/widgets/appbar_widget.dart';
import 'package:fitness/widgets/button_widget.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlarmDetailScreen extends StatefulWidget {
  final Alarm currentAlarm;
  final List<Alarm> alarms;

  const AlarmDetailScreen({Key key, this.currentAlarm, this.alarms})
      : super(key: key);

  @override
  _AlarmDetailScreenState createState() => _AlarmDetailScreenState();
}

class _AlarmDetailScreenState extends State<AlarmDetailScreen> {
  DateTime _chosenDateTime;

  var sDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'];
  var selectedDays = [false, false, false, false, false, false, false];

  var controller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    if (widget.currentAlarm == null) {
      _chosenDateTime = DateTime.now();
    } else {
      var currentTime = DateTime.now();
      _chosenDateTime = DateTime(
          currentTime.year,
          currentTime.month,
          currentTime.day,
          int.parse(widget.currentAlarm.hour),
          int.parse(widget.currentAlarm.min));
      controller.text = widget.currentAlarm.description;
      for (var i = 0; i < 7; i++) {
        selectedDays[i] = widget.currentAlarm.repeat[i];
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  void _showTimePicker() {
    NavigatorService(context).showCustomBottomModal(Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InkWell(
              child: Text(
                S.of(context).cancel,
                style: GoogleFonts.montserrat(fontSize: fontMd),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        Container(
          height: 250,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.time,
            onDateTimeChanged: (val) {
              setState(() {
                _chosenDateTime = val;
              });
            },
          ),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
        isBlur: false,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            appBar: CustomAppbar(
              lendingWidget: InkWell(
                child: Icon(Icons.arrow_back_ios),
                onTap: () => Navigator.of(context).pop(),
              ),
              title: widget.currentAlarm == null
                  ? S.of(context).add_alarm
                  : S.of(context).edit_alarm,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(offsetBase),
                child: Column(
                  children: [
                    BlurWidget(
                        child: Column(
                      children: [
                        Text(
                          S.of(context).set_time,
                          style: GoogleFonts.montserrat(
                              fontSize: fontBase, color: Colors.grey),
                        ),
                        SizedBox(
                          height: offsetMd,
                        ),
                        ClipRRect(
                          borderRadius:
                              BorderRadius.all(Radius.circular(offsetXSm)),
                          child: Container(
                            height: 54.0,
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(offsetXSm))),
                            child: Row(
                              children: [
                                Container(
                                  width: 54.0,
                                  color: Colors.grey.withOpacity(0.3),
                                  child: Center(
                                    child: Icon(Icons.alarm),
                                  ),
                                ),
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  StringService.getTime(_chosenDateTime),
                                  style: GoogleFonts.montserrat(
                                      fontSize: fontMd, fontWeight: weightBold),
                                ))),
                                InkWell(
                                  onTap: () => _showTimePicker(),
                                  child: Container(
                                    width: 54.0,
                                    color: Colors.grey.withOpacity(0.3),
                                    child: Center(
                                      child: Icon(Icons.edit),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                    SizedBox(
                      height: offsetMd,
                    ),
                    BlurWidget(
                        child: Column(
                      children: [
                        Text(
                          S.of(context).set_days,
                          style: GoogleFonts.montserrat(
                              fontSize: fontBase, color: Colors.grey),
                        ),
                        SizedBox(
                          height: offsetMd,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (var day in sDays)
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    var index = sDays.indexOf(day);
                                    selectedDays[index] = !selectedDays[index];
                                  });
                                },
                                child: Container(
                                  width: (MediaQuery.of(context).size.width -
                                          offsetBase * 4) /
                                      9,
                                  height: (MediaQuery.of(context).size.width -
                                          offsetBase * 4) /
                                      9,
                                  decoration: BoxDecoration(
                                      color: selectedDays[sDays.indexOf(day)]
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      offsetBase * 4) /
                                                  18))),
                                  child: Center(
                                    child: Text(
                                      day[0],
                                      style: GoogleFonts.montserrat(
                                          fontSize: fontSm,
                                          fontWeight: weightBold,
                                          color:
                                              selectedDays[sDays.indexOf(day)]
                                                  ? Colors.black
                                                  : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      ],
                    )),
                    SizedBox(
                      height: offsetMd,
                    ),
                    BlurWidget(
                        child: Column(
                      children: [
                        Text(
                          S.of(context).set_ringtone,
                          style: GoogleFonts.montserrat(
                              fontSize: fontBase, color: Colors.grey),
                        ),
                        SizedBox(
                          height: offsetBase,
                        ),
                        TextField(
                          controller: controller,
                          minLines: 3,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          style: GoogleFonts.montserrat(fontSize: fontBase),
                          decoration: InputDecoration(
                            hintText: S.of(context).add_description,
                            hintStyle: GoogleFonts.montserrat(
                                fontSize: fontMd, color: Colors.grey),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.white,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(vertical: offsetMd),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.currentAlarm == null
                                  ? 'Alarm Clock 1'
                                  : widget.currentAlarm.music ??
                                      'Alarm Clock 1',
                              style: GoogleFonts.montserrat(
                                  fontSize: fontBase,
                                  fontWeight: weightSemiBold),
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        )
                      ],
                    )),
                    SizedBox(
                      height: offsetLg,
                    ),
                    FullWidthButton(
                      title: widget.currentAlarm == null
                          ? S.of(context).add_alarm
                          : S.of(context).edit_alarm,
                      action: () async {
                        var desc = controller.text;
                        if (desc.isEmpty) {
                          NavigatorService(context).showSnackbar(
                              S.of(context).alert_alarm_desc, _scaffoldKey,
                              type: SnackBarType.INFO);
                          return;
                        }
                        var alarm = Alarm(
                          hour: '${_chosenDateTime.hour}',
                          min: '${_chosenDateTime.minute}',
                          description: desc,
                          isChecked: true,
                          repeat: selectedDays,
                        );

                        if (widget.currentAlarm == null) {
                          widget.alarms.add(alarm);
                          await PrefService().setAlarms(widget.alarms);
                          Navigator.of(context).pop('add');
                        } else {
                          var index =
                              widget.alarms.indexOf(widget.currentAlarm);
                          widget.alarms[index] = alarm;
                          await PrefService().setAlarms(widget.alarms);
                          Navigator.of(context).pop('edit');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
