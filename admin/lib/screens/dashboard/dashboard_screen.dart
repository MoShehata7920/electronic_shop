import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/menu_controller.dart';
import '../../resources/values_manager.dart';
import '../../widgets/grid_widget.dart';
import '../../widgets/header.dart';
import '../../widgets/product_widget.dart';

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
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            GridWidget(gridScreen: () {
              return const ProductWidget();
            }),
          ],
        ),
      ),
    );
  }
}
