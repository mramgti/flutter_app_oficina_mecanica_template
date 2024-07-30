import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  const GeneralButton({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
