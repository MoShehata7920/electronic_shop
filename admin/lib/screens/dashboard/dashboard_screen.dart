import 'package:admin_panel/resources/icons_manager.dart';
import 'package:admin_panel/widgets/orders_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/menu_controller.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/buttons.dart';
import '../../widgets/grid_orders_widget.dart';
import '../../widgets/grid_products_widget.dart';
import '../../widgets/header.dart';
import '../../widgets/product_widget.dart';
import '../view_all_products/view_all_products_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            Header(
              fct: () {
                context.read<AppMenuController>().controlDashBoardMenu();
              },
              screenTitle: AppStrings.dashBoard,
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonsWidget(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ViewAllProductsScreen(),
                        ));
                      },
                      text: AppStrings.viewAll,
                      icon: AppIcons.store,
                      backgroundColor: Colors.cyan),
                  Text(
                    AppStrings.latestProducts,
                    style: const TextStyle(
                        fontSize: AppSize.s16,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                  ButtonsWidget(
                      onPressed: () {},
                      text: AppStrings.addNew,
                      icon: AppIcons.add,
                      backgroundColor: Colors.cyan),
                ],
              ),
            ),
            GridProductsWidget(
              gridScreen: () {
                return const ProductWidget();
              },
              isMain: true,
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              AppStrings.recentOrders,
              style: const TextStyle(
                  fontSize: AppSize.s16,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            GridOrdersWidget(
              gridScreen: () {
                return const OrderCardWidget();
              },
              isMain: true,
            ),
          ],
        ),
      ),
    );
  }
}
