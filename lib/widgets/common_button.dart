import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  CommonButton({
    Key key,
    this.function,
    this.title,
  }) : super(key: key);

  final Function function;
  final String title;

  @override
  _CommonButtonState createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.function,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: widget.function,
              child: Text(widget.title),
            )));
  }
}
