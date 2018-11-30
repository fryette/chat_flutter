import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final double radius;

  CircleImage(this.radius, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: radius,
        height: radius,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage("https://i.imgur.com/BoN9kdC.png"))));
  }
}
