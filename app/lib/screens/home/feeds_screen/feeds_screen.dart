import 'package:electronic_shop/provider/products_provider.dart';
import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/widgets/empty_screen.dart';
import 'package:electronic_shop/widgets/feed_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/products_model.dart';
import '../../../resources/values_manager.dart';
import '../../../services/utils.dart';
import '../../../widgets/back_arrow_button.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<ProductModel> searchedProductsList = [];

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
    List<ProductModel> allProducts = productProvider.getProducts;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppStrings.allProducts,
            style: TextStyle(
                color: textColor,
                fontSize: AppSize.s22,
                fontWeight: FontWeight.bold),
          ),
          leading: const BackArrowButton(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  focusNode: _searchTextFocusNode,
                  controller: _searchTextController,
                  onChanged: (value) {
                    setState(() {
                      searchedProductsList = productProvider.search(value);
                    });
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          borderSide: const BorderSide(
                              color: Colors.cyan, width: AppSize.s1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          borderSide: const BorderSide(width: AppSize.s1)),
                      hintText: AppStrings.searchText,
                      prefixIcon: const Icon(AppIcons.search),
                      suffix: IconButton(
                        onPressed: () {
                          _searchTextController.clear();
                          _searchTextFocusNode.unfocus();
                        },
                        icon: Icon(
                          AppIcons.close,
                          color: _searchTextFocusNode.hasFocus
                              ? Colors.red
                              : textColor,
                        ),
                      ),
                      iconColor: textColor),
                ),
              ),
              _searchTextController.text.isNotEmpty &&
                      searchedProductsList.isEmpty
                  ? EmptyScreenWidget(
                      emptyScreenAsset: JsonAssets.noResults,
                      emptyScreenTitle: AppStrings.noProductsFound,
                      emptyScreenSubTitle: "",
                      buttonText: "",
                      buttonFunction: () {},
                      isThereButton: false)
                  : GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      childAspectRatio: size.width / (size.height * 0.61),
                      children: List.generate(
                          _searchTextController.text.isNotEmpty
                              ? searchedProductsList.length
                              : allProducts.length, (index) {
                        return ChangeNotifierProvider.value(
                          value: _searchTextController.text.isNotEmpty
                              ? searchedProductsList[index]
                              : allProducts[index],
                          child: const FeedWidget(),
                        );
                      }),
                    ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }
}
