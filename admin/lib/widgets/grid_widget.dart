import 'package:flutter/material.dart';
import '../resources/values_manager.dart';
import '../responsive.dart';
import '../services/utils.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({super.key, required this.gridScreen});

  final Widget Function() gridScreen;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 15,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isDesktop(context)
              ? 4
              : Responsive.isTablet(context)
                  ? 3
                  : 2,
          childAspectRatio: Responsive.isDesktop(context)
              ? size.width < 1400
                  ? 0.96
                  : 1
              : Responsive.isTablet(context)
                  ? size.width < 950
                      ? 1.4
                      : 1.3
                  : 1.1,
          crossAxisSpacing: AppConstants.defaultPadding,
          mainAxisSpacing: AppConstants.defaultPadding,
        ),
        itemBuilder: (context, index) {
          return gridScreen();
        });
  }
}
