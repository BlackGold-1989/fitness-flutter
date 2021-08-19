import 'package:fitness/generated/l10n.dart';
import 'package:fitness/models/alarm.dart';
import 'package:fitness/screens/alarm/alarm_detail_screen.dart';
import 'package:fitness/services/navigator_service.dart';
import 'package:fitness/services/pref_service.dart';
import 'package:fitness/themes/colors.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:fitness/widgets/appbar_widget.dart';
import 'package:fitness/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  List<Alarm> alarms = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    initData();
  }

  void initData() async {
    alarms.clear();
    alarms = await PrefService().getAlarms();
    setState(() {});
  }

  Widget emptyWidget() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: offsetXLg,
          ),
          Icon(
            Icons.alarm,
            size: 120.0,
          ),
          SizedBox(
            height: offsetLg,
          ),
          Text(
            S.of(context).set_alarm,
            style: GoogleFonts.montserrat(fontSize: fontMd),
          ),
        ],
      ),
    );
  }

  void _showAlarmInfo() {
    NavigatorService(context).showCustomBottomModal(Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            S.of(context).alarm_info,
            style: GoogleFonts.montserrat(
                fontSize: fontMd, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: offsetBase),
          width: double.infinity,
          height: 1,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            S.of(context).alarm_info_desc,
            style: GoogleFonts.montserrat(
                fontSize: fontBase, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      isBlur: alarms.isEmpty,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: CustomAppbar(
          lendingWidget: InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.of(context).pop(),
          ),
          title: S.of(context).alarms,
          actions: [
            IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () => _showAlarmInfo()),
          ],
        ),
        body: alarms.isEmpty
            ? emptyWidget()
            : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: offsetBase),
                itemCount: alarms.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: offsetSm, vertical: offsetXSm),
                    child: FocusedMenuHolder(
                        openWithTap: true,
                        menuOffset: offsetSm,
                        child: alarms[i].getWidget(
                            context: context,
                            onChange: () async {
                              alarms[i].isChecked = !alarms[i].isChecked;
                              await PrefService().setAlarms(alarms);
                              setState(() {});
                            }),
                        onPressed: () {},
                        menuItems: [
                          FocusedMenuItem(
                              backgroundColor: backgroundColor,
                              title: Text(
                                S.of(context).edit_alarm,
                                style:
                                    GoogleFonts.montserrat(fontSize: fontBase),
                              ),
                              trailingIcon: Icon(Icons.edit),
                              onPressed: () {
                                NavigatorService(context).pushToWidget(
                                    screen: AlarmDetailScreen(
                                      currentAlarm: alarms[i],
                                      alarms: alarms,
                                    ),
                                    pop: (result) {
                                      if (result != null) {
                                        initData();
                                        NavigatorService(context).showSnackbar(
                                            S.of(context).alert_alarm_edit,
                                            _scaffoldKey);
                                      }
                                    });
                              }),
                          FocusedMenuItem(
                              backgroundColor: backgroundColor,
                              title: Text(
                                S.of(context).delete_alarm,
                                style:
                                    GoogleFonts.montserrat(fontSize: fontBase),
                              ),
                              trailingIcon: Icon(Icons.delete_forever),
                              onPressed: () async {
                                alarms.removeAt(i);
                                await PrefService().setAlarms(alarms);
                                setState(() {});
                                NavigatorService(context).showSnackbar(
                                  S.of(context).alert_alarm_delete,
                                  _scaffoldKey,
                                );
                              }),
                        ]),
                  );
                }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => NavigatorService(context).pushToWidget(
              screen: AlarmDetailScreen(
                alarms: alarms,
              ),
              pop: (result) {
                initData();
                if (result != null) {
                  NavigatorService(context).showSnackbar(
                      S.of(context).alert_alarm_add, _scaffoldKey);
                }
              }),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
