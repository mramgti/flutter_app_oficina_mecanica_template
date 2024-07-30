import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final void Function()? onTap;
  const LoginButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(8)),
        child: const Center(
            child: Text(
          'Log In',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16),
        )),
      ),
    );
  }
}
