import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  final String text;

  Txt({
    this.text = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
    );
  }
}
