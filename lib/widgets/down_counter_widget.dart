import 'package:circular_countdown/circular_countdown.dart';
import 'package:fitness/generated/l10n.dart';
import 'package:fitness/models/lesson.dart';
import 'package:fitness/themes/dimens.dart';
import 'package:flutter/material.dart';
import 'package:timer_controller/timer_controller.dart';

import 'button_widget.dart';

class DownCounterWidget extends StatefulWidget {
  final List<Lesson> lessons;
  final Function(int) onNext;
  final Function() onFinish;

  const DownCounterWidget({Key key, this.onNext, this.onFinish, this.lessons})
      : super(key: key);

  @override
  _DownCounterWidgetState createState() => _DownCounterWidgetState();
}

class _DownCounterWidgetState extends State<DownCounterWidget> {
  TimerController _controller;
  var isLoading = false;
  var isNext = false;
  var isFinish = false;
  var lessonIndex = 0;

  @override
  void initState() {
    super.initState();
    initTimer();
  }

  void initTimer() {
    _controller =
        TimerController.seconds(int.parse(widget.lessons[lessonIndex].during));
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return TimerControllerListener(
      controller: _controller,
      listenWhen: (previousValue, currentValue) =>
          previousValue.status != currentValue.status,
      listener: (context, timerValue) {},
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TimerControllerBuilder(
              controller: _controller,
              builder: (context, timerValue, _) {
                Color timerColor;
                switch (timerValue.status) {
                  case TimerStatus.running:
                    isLoading = true;
                    timerColor = Colors.green;
                    break;
                  case TimerStatus.paused:
                    timerColor = Colors.grey;
                    break;
                  case TimerStatus.finished:
                    isNext = true;
                    if (lessonIndex == widget.lessons.length - 1) {
                      isFinish = true;
                    }
                    isLoading = false;
                    timerColor = Colors.red;
                    break;
                  default:
                }
                return Column(
                  children: <Widget>[
                    CircularCountdown(
                      diameter: 250,
                      countdownTotal: _controller.initialValue.remaining,
                      countdownRemaining: timerValue.remaining,
                      countdownCurrentColor: timerColor,
                      countdownRemainingColor: Colors.white60,
                      countdownTotalColor: Colors.white12,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                      ),
                    ),
                    SizedBox(
                      height: offsetLg,
                    ),
                    FullWidthButton(
                      title: isFinish
                          ? S.of(context).finish
                          : isNext
                              ? S.of(context).next
                              : S.of(context).start,
                      action: isLoading ? null : () => _buttonAction(),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _buttonAction() {
    if (isNext) {
      isNext = false;
      lessonIndex = lessonIndex + 1;
      if (lessonIndex < widget.lessons.length) {
        initTimer();
        widget.onNext(lessonIndex);
      } else {
        widget.onFinish();
      }
    } else {
      _controller.start();
    }
  }
}
