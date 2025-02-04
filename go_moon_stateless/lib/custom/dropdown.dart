import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List items;
  final double width;
  const CustomDropDown({required this.items, required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: width * 0.025),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(53, 53, 43, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        items: items.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (_) {},
        underline: Container(),
        value: items.first, // default value
        dropdownColor: const Color.fromRGBO(53, 53, 43, 1),
        style: const TextStyle(
          color: Colors.white,
        ), // dropdown text style
      ),
    );
  }
}
