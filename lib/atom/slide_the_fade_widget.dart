import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlideAndFadeWidget extends StatefulWidget {
  const SlideAndFadeWidget({
    super.key,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = const Duration(milliseconds: 1000),
    required this.child,
    this.curve = Curves.linear,
  });

  final Duration duration;
  final Duration delay;
  final Widget child;
  final Curve curve;

  @override
  State<SlideAndFadeWidget> createState() => _SlideAndFadeWidgetState();
}

class _SlideAndFadeWidgetState extends State<SlideAndFadeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: widget.duration,
    vsync: this,
  );

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 1, curve: widget.curve),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 0.8, curve: widget.curve),
      ),
    );

    Future.delayed(widget.delay, () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child:
                SlideTransition(position: _slideAnimation, child: widget.child),
          );
        });
  }
}
