import 'package:flutter/widgets.dart';
import 'package:sokari_flutter_interview/model/animation_model.dart';

import 'custom_slider.dart';

class GalleryItem extends StatelessWidget {
  const GalleryItem({
    super.key,
    required this.imagePath,
    this.flex = 1,
    this.sliderText,
    this.sliderDelay = const Duration(milliseconds: 4000),
    required this.animationModel,
  });

  final int flex;
  final String imagePath;
  final String? sliderText;
  final Duration sliderDelay;
  final AnimationModel animationModel;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Expanded(
      flex: flex,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            // width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              image: DecorationImage(
                  image: Image.asset(imagePath).image, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  CustomSlider(
                    height: height * .053,
                    text: sliderText,
                    animationModel: animationModel,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
