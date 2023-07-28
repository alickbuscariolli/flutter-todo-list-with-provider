import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final TextAlign? textAlign;

  const TextWidget(this.text, {this.textAlign, this.fontSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize ?? 16,
      ),
      textAlign: textAlign,
    );
  }
}
