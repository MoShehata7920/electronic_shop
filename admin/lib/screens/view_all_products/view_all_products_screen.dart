import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/menu_controller.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../../responsive.dart';
import '../../widgets/grid_products_widget.dart';
import '../../widgets/header.dart';
import '../../widgets/product_widget.dart';
import '../../widgets/side_menu.dart';

class ViewAllProductsScreen extends StatelessWidget {
  const ViewAllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<AppMenuController>().getGridScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Column(
                  children: [
                    Header(
                      fct: () {
                        context.read<AppMenuController>().controlProductsMenu();
                      },
                      screenTitle: AppStrings.viewAllProducts,
                    ),
                    GridProductsWidget(
                      gridScreen: () {
                        return const ProductWidget();
                      },
                      isMain: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
