import 'package:flutter/material.dart';
import 'package:flutter_todos_app/utils/utils.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    Key? key,
    this.child,
    this.height,
  }) : super(key: key);
  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    return Container(
      height: height,
      width: deviceSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 237, 238, 235),
      ),
      child: child,
    );
  }
}
