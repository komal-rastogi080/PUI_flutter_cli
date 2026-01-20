import 'package:flutter/material.dart';

class GlowContainer extends StatelessWidget {
  final Widget child;
  final Color glow;

  const GlowContainer({
    super.key,
    required this.child,
    required this.glow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: glow.withOpacity(0.35),
            blurRadius: 30,
            spreadRadius: 5,
          )
        ],
      ),
      child: child,
    );
  }
}
