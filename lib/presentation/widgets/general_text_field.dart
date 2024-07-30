import 'package:flutter/material.dart';

class GeneralTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscuretext;
  const GeneralTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscuretext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscuretext,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(99, 0, 0, 0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Color.fromARGB(161, 32, 32, 32),
                fontWeight: FontWeight.w500,
                fontSize: 14)),
      ),
    );
  }
}
