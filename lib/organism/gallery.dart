import 'package:flutter/material.dart';
import 'package:sokari_flutter_interview/generated/assets.dart';
import 'package:sokari_flutter_interview/model/animation_model.dart';
import 'package:sokari_flutter_interview/molecule/gallery_item.dart';

class Gallery extends StatelessWidget {
  const Gallery(
      {super.key, required this.height, required this.animationModel});

  final double height;
  final AnimationModel animationModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GalleryItem(
            animationModel: animationModel,
            imagePath: Assets.imagesImg1,
            sliderText: "Ademola St. 34",
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                GalleryItem(
                  animationModel: animationModel,
                  imagePath: Assets.imagesImg2,
                  sliderText: "24 Dumo St.",
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      GalleryItem(
                          animationModel: animationModel,
                          sliderText: "345 Saidu Road",
                          imagePath: Assets.imagesImg3),
                      const SizedBox(
                        height: 10,
                      ),
                      GalleryItem(
                          animationModel: animationModel,
                          sliderText: "2 Fedora Road.",
                          imagePath: Assets.imagesImg4),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
