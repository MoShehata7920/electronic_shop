import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/widgets/on_sale_widget.dart';
import 'package:flutter/material.dart';
import '../../../resources/values_manager.dart';
import '../../../services/utils.dart';
import '../../../widgets/back_arrow_button.dart';

class OnSaleProductsScreen extends StatefulWidget {
  const OnSaleProductsScreen({super.key});

  @override
  State<OnSaleProductsScreen> createState() => _OnSaleProductsScreenState();
}

class _OnSaleProductsScreenState extends State<OnSaleProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;
    Size size = Utils(context).screenSize;

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
        body: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          padding: EdgeInsets.zero,
          childAspectRatio: size.width / (size.height * 0.61),
          children: List.generate(15, (index) {
            return const OnSaleWidget();
          }),
        ));
  }
}
