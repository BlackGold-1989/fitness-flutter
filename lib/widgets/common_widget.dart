import 'dart:ui';

import 'package:fitness/themes/dimens.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends Container {
  BackgroundWidget(
      {Key key,
      @required Widget child,
      bool isBlur = true,
      String backImage = 'assets/images/img_back_01.png'})
      : super(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(backImage),
              fit: BoxFit.cover,
            ),
          ),
          child: isBlur
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.3)),
                    child: child,
                  ),
                )
              : child,
        );
}

class BlurWidget extends Container {
  BlurWidget({
    Key key,
    @required Widget child,
    EdgeInsets padding = const EdgeInsets.all(offsetMd),
    EdgeInsets margin = EdgeInsets.zero,
    double cornerRadius = offsetBase,
  }) : super(
            margin: margin,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  width: double.infinity,
                  padding: padding,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius:
                          BorderRadius.all(Radius.circular(cornerRadius))),
                  child: child,
                ),
              ),
            ));
}

class AnimatedListItem extends StatefulWidget {
  final int index;
  final Widget child;

  AnimatedListItem(this.index, {Key key, @required this.child})
      : super(key: key);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  bool _animate = false;

  static bool _isStart = true;

  @override
  void initState() {
    super.initState();
    _isStart
        ? Future.delayed(Duration(milliseconds: widget.index * 100), () {
            setState(() {
              _animate = true;
              _isStart = false;
            });
          })
        : _animate = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1000),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 1000),
        padding: _animate
            ? const EdgeInsets.all(4.0)
            : const EdgeInsets.only(top: 10),
        child: widget.child,
      ),
    );
  }
}

class BadgeWidget extends StatelessWidget {
  final String badge;

  const BadgeWidget({Key key, this.badge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (badge != 'NONE')
        ? Padding(
            padding: const EdgeInsets.all(2.0),
            child: badge == 'HOT'
                ? Icon(
                    Icons.whatshot_sharp,
                    color: Colors.red,
                    size: 36.0,
                  )
                : Icon(
                    Icons.fiber_new,
                    color: Colors.blue,
                    size: 36.0,
                  ),
          )
        : Container();
  }
}

class DividerWidget extends Padding {
  DividerWidget({
    Key key,
    Color color = Colors.grey,
    double thickness = 0.5,
    EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  }) : super(
          padding: padding,
          child: Divider(
            key: key,
            color: color,
            thickness: thickness,
            height: 0,
          ),
        );
}
