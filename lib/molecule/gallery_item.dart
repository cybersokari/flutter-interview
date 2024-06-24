import 'package:flutter/widgets.dart';

import 'custom_slider.dart';

class GalleryItem extends StatelessWidget {
  const GalleryItem(
      {super.key, required this.imagePath, this.flex = 1, this.sliderText});

  final int flex;
  final String imagePath;
  final String? sliderText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              image: DecorationImage(
                  image: Image.asset(imagePath).image, fit: BoxFit.cover),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomSlider(
                    text: "Ademola St. 34",
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
