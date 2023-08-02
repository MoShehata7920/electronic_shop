import 'package:electronic_shop/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../services/utils.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key,
      required this.categoryName,
      required this.imagePath,
      required this.cardColor});

  final String categoryName, imagePath;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;
    double cardWidth = size.width;

    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: cardColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: cardColor.withOpacity(0.7), width: AppSize.s2)),
        child: Column(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                cardColor.withOpacity(0.1),
                BlendMode.srcATop,
              ),
              child: SizedBox(
                height: cardWidth * 0.3,
                width: cardWidth * 0.3,
                child: Lottie.asset(
                  imagePath, // Replace with the path to your Lottie animation asset
                  fit: BoxFit.fill, // Adjust the BoxFit as needed
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s2),
              child: Text(
                categoryName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: AppSize.s18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
