// ignore_for_file: no_logic_in_create_state

import 'package:electronic_shop/widgets/feed_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/products_model.dart';
import '../../provider/products_provider.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../../services/utils.dart';
import '../../widgets/back_arrow_button.dart';
import '../../widgets/empty_screen.dart';

class CategoryScreen extends StatefulWidget {
  final Object? categoryName;
  const CategoryScreen(this.categoryName, {Key? key}) : super(key: key);

  @override
  CategoryScreenState createState() =>
      CategoryScreenState(categoryName as String);
}

class CategoryScreenState extends State<CategoryScreen> {
  String categoryName;
  CategoryScreenState(this.categoryName);

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 5), () async {
      final productsProvider =
          Provider.of<ProductProvider>(context, listen: false);
      await productsProvider.fetchProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;
    Size size = Utils(context).screenSize;

    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> categoryList =
        productProvider.findByCategory(categoryName);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            categoryName,
            style: TextStyle(
                color: textColor,
                fontSize: AppSize.s22,
                fontWeight: FontWeight.bold),
          ),
          leading: const BackArrowButton(),
        ),
        body: categoryList.isEmpty
            ? EmptyScreenWidget(
                emptyScreenAsset: JsonAssets.empty,
                emptyScreenTitle: AppStrings.oops,
                emptyScreenSubTitle: AppStrings.emptyCategoryList,
                buttonText: "",
                buttonFunction: () {},
                isThereButton: false,
              )
            : GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                padding: EdgeInsets.zero,
                childAspectRatio: size.width / (size.height * 0.61),
                children: List.generate(categoryList.length, (index) {
                  return ChangeNotifierProvider.value(
                      value: categoryList[index], child: const FeedWidget());
                }),
              ));
  }
}
