import 'package:flutter/material.dart';

class TaskTextFields extends StatelessWidget {
  final TextEditingController controller;

  const TaskTextFields(
      {super.key,
      required this.controller,
      required this.icon,
      required this.hintText,
      this.iconButton,
      this.onIconButtonClick});

  final String hintText;
  final IconData icon;
  final IconData? iconButton;
  final VoidCallback? onIconButtonClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 10.0,
              ),
              suffixIcon: GestureDetector(
                onTap: onIconButtonClick,
                child: Icon(iconButton),
              ),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                controller.clear();
              }
            },
          ),
        ),
      ],
    );
  }
}
