import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomCard extends StatelessWidget {
  double? width, height;
  late Widget child;

  CustomCard(
      {required this.width,
      required this.height,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 1),
          ),
        ],
      ),
      width: width!,
      height: height!,
      child: child,
    );
  }
}
