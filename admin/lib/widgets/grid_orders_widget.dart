import 'package:flutter/material.dart';
import '../resources/values_manager.dart';
import '../responsive.dart';
import '../services/utils.dart';

class GridOrdersWidget extends StatelessWidget {
  const GridOrdersWidget(
      {super.key, required this.gridScreen, required this.isMain});

  final Widget Function() gridScreen;
  final bool isMain;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: isMain ? 4 : 15,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: Responsive.isDesktop(context)
              ? size.width < 1400
                  ? 4.1
                  : 4.9
              : Responsive.isTablet(context)
                  ? size.width < 950
                      ? 5.3
                      : 5.4
                  : 2.2,
          crossAxisSpacing: AppConstants.defaultPadding,
          mainAxisSpacing: AppConstants.defaultPadding,
        ),
        itemBuilder: (context, index) {
          return gridScreen();
        });
  }
}
