import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sokari_flutter_interview/generated/assets.dart';

class CustomSlider extends StatefulWidget {
  final double height;
  final animationDuration = const Duration(milliseconds: 10);
  final Duration autoMoveDelay;
  final String? text;
  final Function()? onSlided;
  final bool enabled;

  const CustomSlider({
    this.onSlided,
    this.text,
    this.enabled = true,
    this.autoMoveDelay = const Duration(seconds: 2),
    super.key,
    this.height = 31,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  Radius get _radius => Radius.circular(widget.height);
  bool slide = false;
  double _textOpacity = 0;
  final animationDuration = 2000.milliseconds;
  final animationCurve = Curves.fastOutSlowIn;

  @override
  void initState() {
    super.initState();

    Future.delayed(widget.autoMoveDelay, () {
      if (widget.enabled) {
        setState(() {
          slide = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(_radius),
      ),
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          final sliderRadius = widget.height / 2;
          final sliderMaxX = constraints.maxWidth - 2 * sliderRadius;
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(_radius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: AnimatedContainer(
                    curve: animationCurve,
                    width: slide ? constraints.maxWidth : constraints.minWidth,
                    height: widget.height,
                    color: const Color.fromRGBO(196, 183, 166, .7),
                    duration: animationDuration,
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: animationCurve,
                left: slide ? sliderMaxX : constraints.minWidth,
                duration: animationDuration,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: widget.height,
                  width: widget.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(_radius),
                    color: Colors.white,
                  ),
                  child: SvgPicture.asset(Assets.iconsRightArrowLine),
                ),
                onEnd: () {
                  setState(() {
                    _textOpacity = 1;
                  });
                  widget.onSlided?.call();
                },
              ),
              _buildText(constraints.maxWidth),
            ],
          );
        },
      ),
    );
  }

  Widget _buildText(double width) {
    if (widget.text == null) {
      return const SizedBox();
    }
    return SizedBox(
      height: widget.height,
      width: width - widget.height,
      child: Center(
        child: AnimatedOpacity(
          opacity: _textOpacity,
          duration: const Duration(milliseconds: 1000),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AutoSizeText(
              textAlign: TextAlign.center,
              maxFontSize: 17,
              minFontSize: 8,
              maxLines: 1,
              widget.text!,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ),
    );
  }
}
