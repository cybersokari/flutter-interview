import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sokari_flutter_interview/extensions/number_duration_extensions.dart';
import 'package:sokari_flutter_interview/generated/assets.dart';
import 'package:sokari_flutter_interview/model/animation_model.dart';

class CustomSlider extends StatefulWidget {
  final double height;
  final Duration animationDuration;
  final String? text;
  final Function()? onSlided;
  final AnimationModel animationModel;

  const CustomSlider({
    this.onSlided,
    this.text,
    super.key,
    this.height = 31,
    this.animationDuration = const Duration(milliseconds: 2000),
    required this.animationModel,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider>
    with SingleTickerProviderStateMixin {
  Radius get _radius => Radius.circular(widget.height);
  bool slide = false;
  double _textOpacity = 0;
  final animationCurve = Curves.linear;
  bool sliderMovedAfterScaling = false;
  late final AnimationController _scaleAnimationController =
      AnimationController(
    duration: 500.milliseconds,
    vsync: this,
  );
  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _scaleAnimationController,
    curve: Curves.linear,
  );

  @override
  void initState() {
    super.initState();
    _scaleAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _moveSliderAfterScaling();
      }
    });
    widget.animationModel.addListener(() {
      _scaleAnimationController.forward();
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.animationModel.dispose();
    _scaleAnimationController.dispose();
    super.dispose();
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
          return ScaleTransition(
            alignment: Alignment.centerLeft,
            scale: _scaleAnimation,
            child: Stack(
              children: [
                _buildBackground(
                    constraints.minWidth + sliderRadius, constraints.maxWidth),
                _buildSlider(constraints.minWidth, sliderMaxX),
                _buildText(constraints.maxWidth),
              ],
            ),
          );
        },
      ),
    );
  }

  void _moveSliderAfterScaling() {
    sliderMovedAfterScaling = true;
    setState(() {});
  }

  Widget _buildBackground(double startX, double endX) {
    return ClipRRect(
      borderRadius: BorderRadius.all(_radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: AnimatedContainer(
          curve: animationCurve,
          width: sliderMovedAfterScaling ? endX : startX,
          height: widget.height,
          color: const Color.fromRGBO(196, 183, 166, .7),
          duration: widget.animationDuration,
        ),
      ),
    );
  }

  Widget _buildSlider(double startX, double endX) {
    return AnimatedPositioned(
      curve: animationCurve,
      left: sliderMovedAfterScaling ? endX : startX,
      duration: widget.animationDuration,
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
