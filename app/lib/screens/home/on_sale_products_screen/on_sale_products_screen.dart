import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/widgets/on_sale_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/products_model.dart';
import '../../../provider/products_provider.dart';
import '../../../resources/values_manager.dart';
import '../../../services/utils.dart';
import '../../../widgets/back_arrow_button.dart';
import '../../../widgets/empty_screen.dart';

class OnSaleProductsScreen extends StatefulWidget {
  const OnSaleProductsScreen({super.key});

  @override
  State<OnSaleProductsScreen> createState() => _OnSaleProductsScreenState();
}

class _OnSaleProductsScreenState extends State<OnSaleProductsScreen> {
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
    List<ProductModel> onSaleProducts = productProvider.getOnSaleProducts;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppStrings.onSaleProducts,
            style: TextStyle(
                color: textColor,
                fontSize: AppSize.s22,
                fontWeight: FontWeight.bold),
          ),
          leading: const BackArrowButton(),
        ),
        body: onSaleProducts.isEmpty
            ? EmptyScreenWidget(
                emptyScreenAsset: JsonAssets.empty,
                emptyScreenTitle: AppStrings.unfortunately,
                emptyScreenSubTitle: AppStrings.emptyOnSaleList,
                buttonText: "",
                buttonFunction: () {},
                isThereButton: false,
              )
            : GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                padding: EdgeInsets.zero,
                childAspectRatio: size.width / (size.height * 0.61),
                children: List.generate(onSaleProducts.length, (index) {
                  return ChangeNotifierProvider.value(
                      value: onSaleProducts[index],
                      child: const OnSaleWidget());
                }),
              ));
  }
}
