import 'package:flutter/material.dart';

class InkWellButton extends StatelessWidget {
  const InkWellButton({
    super.key,
    required this.onTap,
    required this.child,
    this.borderRadius = 25,
  });

  final Function() onTap;
  final Widget child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: Colors.orange,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
