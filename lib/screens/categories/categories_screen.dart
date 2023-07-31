import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/widgets/category_card.dart';
import 'package:flutter/material.dart';
import '../../resources/assets_manager.dart';
import '../../services/utils.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Map<String, dynamic>> categoryInfo = [
    {
      'imgPath': JsonAssets.tv,
      'categoryName': AppStrings.audioVideo,
    },
    {
      'imgPath': JsonAssets.laptop,
      'categoryName': AppStrings.consumerElectronics,
    },
    {
      'imgPath': JsonAssets.gaming,
      'categoryName': AppStrings.gaming,
    },
    {
      'imgPath': JsonAssets.printer,
      'categoryName': AppStrings.officeElectronics,
    },
    {
      'imgPath': JsonAssets.washingMachine,
      'categoryName': AppStrings.homeAppliances,
    },
    {
      'imgPath': JsonAssets.others,
      'categoryName': AppStrings.others,
    },
  ];

  List<Color> cardColor = [
    const Color(0xffF8A44C),
    const Color(0xff53B175),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color textColor = utils.textColor;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            AppStrings.categories,
            style: TextStyle(
              fontSize: AppSize.s24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 260,
            crossAxisSpacing: AppSize.s10,
            mainAxisSpacing: AppSize.s10,
            children: List.generate(AppConstants.numOfCategories, (index) {
              return CategoryCard(
                categoryName: categoryInfo[index]['categoryName'],
                imagePath: categoryInfo[index]['imgPath'],
                cardColor: cardColor[index],
              );
            }),
          ),
        ));
  }
}
