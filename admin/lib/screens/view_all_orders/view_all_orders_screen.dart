import 'package:admin_panel/widgets/grid_orders_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/menu_controller.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../../responsive.dart';
import '../../widgets/header.dart';
import '../../widgets/side_menu.dart';

class ViewAllOrdersScreen extends StatelessWidget {
  const ViewAllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<AppMenuController>().getOrdersScaffoldKey,
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
                        context.read<AppMenuController>().controlOrdersMenu();
                      },
                      screenTitle: AppStrings.viewAllOrders,
                    ),
                    const GridOrdersWidget(
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
