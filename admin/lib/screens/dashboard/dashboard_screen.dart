import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/menu_controller.dart';
import '../../resources/values_manager.dart';
import '../../widgets/header.dart';

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
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
