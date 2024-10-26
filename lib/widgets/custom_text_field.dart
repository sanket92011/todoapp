import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.showText});

  final String hintText;
  TextEditingController controller = TextEditingController();
  final bool? showText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: showText == true ? false : true,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
