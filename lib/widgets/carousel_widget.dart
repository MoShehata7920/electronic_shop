import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class SwiperWidget extends StatelessWidget {
  const SwiperWidget(
      {super.key,
      required this.carouselImages,
      required this.isSwiperPaginationActive});

  final List carouselImages;
  final bool isSwiperPaginationActive;

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.asset(
          carouselImages[index],
          fit: BoxFit.fill,
        );
      },
      autoplay: true,
      itemCount: carouselImages.length,
      pagination: isSwiperPaginationActive
          ? SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                  activeColor: Colors.cyan,
                  color: Colors.blueGrey.withOpacity(0.5)))
          : null,
    );
  }
}
