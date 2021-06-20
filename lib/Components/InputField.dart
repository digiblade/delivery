import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hint;
  final bool isFilled;
  final Color textColor;
  final Color hintColor;
  final Color fillColor;
  final Color borderColor;
  final TextInputType keyType;
  final Function(String) onChange;
  const InputField({
    Key key,
    this.controller,
    this.isPassword = false,
    this.hint,
    this.isFilled = true,
    this.textColor,
    this.hintColor,
    this.fillColor,
    this.borderColor,
    this.keyType = TextInputType.emailAddress,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: keyType,
      onSubmitted: (val) {
        onChange(val);
      },
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
        filled: isFilled,
        hintText: hint,
        hintStyle: TextStyle(color: hintColor),
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            width: 1,
            color: Colors.white,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            width: 1,
            color: borderColor,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            width: 1,
            color: borderColor,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
