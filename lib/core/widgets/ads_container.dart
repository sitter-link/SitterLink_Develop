import 'package:carousel_slider/carousel_slider.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:nanny_app/core/images/custom_network_image.dart';
import 'package:nanny_app/core/utils/size_utils.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 6,
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.wp),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomCachedNetworkImage(
              url: Faker().image.image(random: true, keywords: ["ads"]),
              fit: BoxFit.cover,
              width: 300.wp,
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 280.hp,
      ),
    );
  }
}
