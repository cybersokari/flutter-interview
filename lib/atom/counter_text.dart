import 'package:flutter/cupertino.dart';

class AnimatedCounterText extends ImplicitlyAnimatedWidget {
  const AnimatedCounterText({
    super.key,
    required super.duration,
    required this.value,
    required this.style,
    required this.resizeDuration,
  });

  final int value;
  final TextStyle style;
  final Duration resizeDuration;

  @override
  ImplicitlyAnimatedWidgetState<AnimatedCounterText> createState() =>
      _AnimatedCounterTextState();
}

class _AnimatedCounterTextState
    extends AnimatedWidgetBaseState<AnimatedCounterText> {
  late IntTween _counter;

  @override
  void initState() {
    _counter = IntTween(begin: widget.value, end: widget.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      style: widget.style,
      duration: widget.resizeDuration,
      child: Text(
        "${_counter.evaluate(animation)}",
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _counter = visitor(
        _counter,
        widget.value,
        (value) => IntTween(
              begin: value,
            )) as IntTween;
  }
}
