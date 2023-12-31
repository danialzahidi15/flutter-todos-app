// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({
    Key? key,
    required this.color,
    this.child,
  }) : super(key: key);

  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: child,
    );
  }
}
