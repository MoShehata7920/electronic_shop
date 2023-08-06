import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/menu_controller.dart';
import '../../resources/icons_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../../responsive.dart';
import '../../services/utils.dart';
import '../../widgets/buttons.dart';
import '../../widgets/header.dart';
import '../../widgets/side_menu.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<AppMenuController>().getAddProductScaffoldKey,
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
                      screenTitle: AppStrings.addNewProduct,
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    _buildScreenWidget(context)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenWidget(BuildContext context) {
    final textColor = Utils(context).textColor;

    final formKey = GlobalKey<FormState>();
    final productTitleTextController = TextEditingController();
    final productPriceTextController = TextEditingController();

    return Column(
      children: [
        _getImage(context),
        const SizedBox(height: AppConstants.defaultPadding),
        Form(
            key: formKey,
            child: TextFormField(
              textInputAction: TextInputAction.next,
              controller: productTitleTextController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return AppStrings.notValidProductTitle;
                }
              },
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: AppStrings.productTitle,
                hintText: AppStrings.enterProductTitle,
                hintStyle: TextStyle(color: textColor),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor),
                    borderRadius: BorderRadius.circular(AppSize.s12)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: textColor),
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: productPriceTextController,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return AppStrings.notValidPrice;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: AppStrings.price,
                      hintText: AppStrings.enterPrice,
                      prefixText: AppStrings.egyptianPound,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textColor),
                          borderRadius: BorderRadius.circular(AppSize.s12)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: DropdownButtonFormField<String>(
                    dropdownColor: Theme.of(context).cardColor,
                    decoration: InputDecoration(
                      labelText: AppStrings.category,
                      hintText: AppStrings.chooseCategory,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textColor),
                          borderRadius: BorderRadius.circular(AppSize.s12)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return AppStrings.notValidCategory;
                      }
                    },
                    items: [
                      DropdownMenuItem(
                          value: AppStrings.audioVideo,
                          child: Text(AppStrings.audioVideo)),
                      DropdownMenuItem(
                          value: AppStrings.consumerElectronics,
                          child: Text(AppStrings.consumerElectronics)),
                      DropdownMenuItem(
                          value: AppStrings.gaming,
                          child: Text(AppStrings.gaming)),
                      DropdownMenuItem(
                          value: AppStrings.officeElectronics,
                          child: Text(AppStrings.officeElectronics)),
                      DropdownMenuItem(
                          value: AppStrings.homeAppliances,
                          child: Text(AppStrings.homeAppliances)),
                      DropdownMenuItem(
                          value: AppStrings.others,
                          child: Text(AppStrings.others)),
                    ],
                    onChanged: (newValue) {},
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: ButtonsWidget(
                    onPressed: () {},
                    text: AppStrings.clearForm,
                    icon: AppIcons.delete,
                    backgroundColor: Colors.red),
              ),
              Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: ButtonsWidget(
                    onPressed: () {},
                    text: AppStrings.upload,
                    icon: AppIcons.upload,
                    backgroundColor: Colors.cyan),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getImage(BuildContext context) {
    final textColor = Utils(context).textColor;

    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s12),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(AppConstants.defaultPadding),
              child: Icon(
                AppIcons.image,
                size: AppSize.s70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: RichText(
                text: TextSpan(
                  text: AppStrings.dropImage,
                  style: TextStyle(
                    color: textColor,
                    fontSize: AppSize.s24,
                    overflow: TextOverflow.ellipsis,
                  ),
                  children: [
                    TextSpan(
                      text: AppStrings.clickToBrowse,
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontSize: AppSize.s24,
                        overflow: TextOverflow.ellipsis,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
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
