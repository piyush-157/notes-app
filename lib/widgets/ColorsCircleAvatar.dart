import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget
{

  Color color;
  VoidCallback onPressed;

  ColorButton({this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      child: InkWell(
        onTap: onPressed,
        child: CircleAvatar(
          radius: 10,
          backgroundColor: color,
        ),
      ),
    );
  }

}
