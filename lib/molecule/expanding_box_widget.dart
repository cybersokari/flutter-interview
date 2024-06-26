import 'package:flutter/material.dart';
import 'package:sokari_flutter_interview/extensions/number_duration_extensions.dart';

class ExpandingBox extends StatefulWidget {
  const ExpandingBox({
    super.key,
    required this.size,
    required this.child,
    required this.decoration,
    this.animationDelay = const Duration(milliseconds: 1000),
    required this.borderRadius,
    this.onAnimationEnd,
  });

  final double size;
  final Widget child;
  final BoxDecoration decoration;
  final BorderRadiusGeometry borderRadius;
  final Duration animationDelay;
  final Function()? onAnimationEnd;

  @override
  State<ExpandingBox> createState() => _ExpandingBoxState();
}

class _ExpandingBoxState extends State<ExpandingBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleAnimationController =
      AnimationController(
    duration: 1000.milliseconds,
    vsync: this,
  );
  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _scaleAnimationController,
    curve: Curves.linear,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(
        widget.animationDelay, () => _scaleAnimationController.forward());
    _scaleAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationEnd?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: Container(
          height: widget.size,
          width: widget.size,
          padding: const EdgeInsets.all(20),
          decoration: widget.decoration,
          child: widget.child,
        ),
      ),
    );
  }
}
