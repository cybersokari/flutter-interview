import 'package:flutter/material.dart';
import 'package:sokari_flutter_interview/generated/assets.dart';
import 'package:sokari_flutter_interview/molecule/gallery_item.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key, required this.height});

  final double height;

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
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GalleryItem(
            imagePath: Assets.imagesImg1,
            sliderText: 'Slide to Unlock',
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                GalleryItem(imagePath: Assets.imagesImg2),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      GalleryItem(imagePath: Assets.imagesImg3),
                      SizedBox(
                        height: 10,
                      ),
                      GalleryItem(imagePath: Assets.imagesImg4),
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
