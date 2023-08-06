import 'package:admin_panel/resources/icons_manager.dart';
import 'package:flutter/material.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';
import '../responsive.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.fct,
    required this.screenTitle,
  }) : super(key: key);

  final Function fct;
  final String screenTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(AppIcons.menu),
            onPressed: () {
              fct();
            },
          ),
        if (Responsive.isDesktop(context))
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(
              screenTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        if (Responsive.isDesktop(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: AppStrings.search,
              fillColor: Theme.of(context).cardColor,
              filled: true,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
              ),
              suffixIcon: InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.all(AppConstants.defaultPadding * 0.75),
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppConstants.defaultPadding / 2),
                  decoration: const BoxDecoration(
                    color: Colors.cyan,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppSize.s10)),
                  ),
                  child: const Icon(
                    AppIcons.search,
                    size: AppSize.s25,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
