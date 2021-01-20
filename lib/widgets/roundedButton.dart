import 'package:bloc_pattern_flutter_app/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  RoundedButton({Key key, @required this.title, @required this.parentAction, this.fontSize: 17, this.height: 40, this.width})
      : super(key: key);

  final String title;
  final void Function() parentAction;
  final double height;
  final double width;
  final double fontSize;

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: new BorderRadius.circular(30),
      child: GestureDetector(
        onTap: () {
          if (widget.parentAction != null) widget.parentAction();
        },
        child: Container(
//            color: Constant.colorPurpleLight,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff6E4396),
              Color(0xff5B2884),
              Color(0xff4A0E75),
            ],
          )),
          height: widget.height,
          width: widget.width,
          child: Center(
              child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: widget.fontSize,
              fontFamily: Constant.fontMyraidPro,
            ),
          )),
        ),
      ),
    );
  }
}
