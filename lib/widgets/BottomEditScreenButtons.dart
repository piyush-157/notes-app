import 'package:flutter/material.dart';

class BottomEditScreenButtons extends StatelessWidget
{

  String image;
  Color color;
  VoidCallback onPressed;

  BottomEditScreenButtons({this.image, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      width: 66,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(7),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Image.asset(image),
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: const CircleBorder(),
        ),
      ),
    );
  }

}