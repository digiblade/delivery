import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String text;
  final Color textColor;
  final double height;
  const Button({
    Key key,
    @required this.onPressed,
    this.color = Colors.black,
    this.text,
    this.textColor = Colors.white,
    this.height = 42.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        // color: Color(0xff040707),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
