import 'package:flutter/material.dart';

class AppBarIcons extends StatelessWidget
{

  String image;
  VoidCallback onPressed;

  AppBarIcons({this.image,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 65,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(7),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Image.asset("assets/$image"),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: const CircleBorder(),
        ),
      ),
    );
  }

}