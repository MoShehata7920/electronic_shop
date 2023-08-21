// ignore_for_file: use_build_context_synchronously, no_logic_in_create_state

import 'dart:io';
import 'package:admin_panel/resources/assets_manager.dart';
import 'package:admin_panel/widgets/loading_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../controllers/menu_controller.dart';
import '../../resources/icons_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../../responsive.dart';
import '../../services/global_method.dart';
import '../../services/utils.dart';
import '../../widgets/buttons.dart';
import '../../widgets/header.dart';
import '../../widgets/side_menu.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen(this.productId, {Key? key}) : super(key: key);
  final Object? productId;

  @override
  EditProductScreenState createState() =>
      EditProductScreenState(productId as String);
}

class EditProductScreenState extends State<EditProductScreen> {
  String productId;
  EditProductScreenState(this.productId);

  @override
  void initState() {
    getProductsData();
    super.initState();
  }

  Future<void> getProductsData() async {
    try {
      final DocumentSnapshot productsDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();
      setState(() {
        productTitleTextController.text = productsDoc.get('title');
        productDescriptionTextController.text = productsDoc.get('description');
        _selectedCategory = productsDoc.get('productCategoryName');
        imageUrl = productsDoc.get('imageUrl');
        productPriceTextController.text = productsDoc.get('price');
        productSalePriceTextController.text = productsDoc.get('salePrice');
        isOnSale = productsDoc.get('isOnSale');
      });
    } catch (error) {
      GlobalMethods.errorDialog(title: '$error', context: context);
    } finally {}
  }

  File? _pickedImage;
  Uint8List webImage = Uint8List(8);

  String? _selectedCategory;

  final formKey = GlobalKey<FormState>();
  final productTitleTextController = TextEditingController();
  final productDescriptionTextController = TextEditingController();
  final productPriceTextController = TextEditingController();
  final productSalePriceTextController = TextEditingController();
  bool isOnSale = false;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<AppMenuController>().getEditProductScaffoldKey,
      drawer: const SideMenu(),
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
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
                          context
                              .read<AppMenuController>()
                              .controlEditProductsMenu();
                        },
                        screenTitle: AppStrings.editProduct,
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
      ),
    );
  }

  Widget _buildScreenWidget(BuildContext context) {
    final textColor = Utils(context).textColor;

    return Form(
      key: formKey,
      child: Column(
        children: [
          _getImage(context),
          const SizedBox(height: AppConstants.defaultPadding),
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
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    child: TextFormField(
                      controller: productDescriptionTextController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return AppStrings.notValidProductTitle;
                        }
                      },
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: AppStrings.productDescription,
                        hintText: AppStrings.enterProductDescription,
                        hintStyle: TextStyle(color: textColor),
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
              ],
            ),
          ),
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
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: productSalePriceTextController,
                      onChanged: (value) {
                        setState(() {
                          isOnSale = value.isNotEmpty;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty && isOnSale) {
                          return AppStrings.notValidPrice;
                        }
                        if (double.parse(productSalePriceTextController.text) >
                            double.parse(productPriceTextController.text)) {
                          return AppStrings.notValidSalePrice;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: AppStrings.salePrice,
                        hintText: AppStrings.enterPrice,
                        prefixText: AppStrings.egyptianPound,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textColor),
                          borderRadius: BorderRadius.circular(AppSize.s12),
                        ),
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
                      value: _selectedCategory,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
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
                      onPressed: () async {
                        GlobalMethods.warningDialog(
                          title: 'Delete?',
                          subtitle: 'Press okay to confirm',
                          warningIcon: JsonAssets.warning,
                          function: () async {
                            await FirebaseFirestore.instance
                                .collection('products')
                                .doc(productId)
                                .delete();
                            await Fluttertoast.showToast(
                              msg: "Product has been deleted",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                            );
                            while (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                          context: context,
                        );
                      },
                      text: AppStrings.delete,
                      icon: AppIcons.delete,
                      backgroundColor: Colors.red),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: ButtonsWidget(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _editProduct(context);
                        }
                      },
                      text: AppStrings.edit,
                      icon: AppIcons.edit,
                      backgroundColor: Colors.cyan),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isLoading = false;

  void _editProduct(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      formKey.currentState!.save();
      if (_pickedImage == null) {
        GlobalMethods.errorDialog(
            title: 'Please pick up an image', context: context);
        return;
      }
      try {
        setState(() {
          _isLoading = true;
        });
        final ref = FirebaseStorage.instance
            .ref()
            .child('productsImages')
            .child('$productId.jpg');

        String contentType = 'image/jpg';

        if (kIsWeb) {
          await ref.putData(
            webImage,
            SettableMetadata(contentType: contentType),
          );
        } else {
          await ref.putFile(
            _pickedImage!,
            SettableMetadata(contentType: contentType),
          );
        }

        imageUrl = await ref.getDownloadURL();

        final logger = Logger();
        logger.i(imageUrl);

        await FirebaseFirestore.instance
            .collection('products')
            .doc('${productId}jpg')
            .update({
          'title': productTitleTextController.text,
          'description': productDescriptionTextController.text,
          'price': productPriceTextController.text,
          'salePrice': productSalePriceTextController.text,
          'imageUrl': imageUrl, // Set the actual image URL
          'productCategoryName': _selectedCategory,
          'isOnSale': isOnSale,
          'createdAt': Timestamp.now(),
        });
        Fluttertoast.showToast(
          msg: "Product Edited successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
        );
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(title: '${error.message}', context: context);
        final logger = Logger();
        logger.e(error.message);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(title: '$error', context: context);
        final logger = Logger();
        logger.e(error);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _getImage(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    return InkWell(
      onTap: () {
        _pickImage();
      },
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s12),
              color: Theme.of(context).cardColor,
            ),
            child: _pickedImage == null
                ? _noPickedImageYet()
                : kIsWeb
                    ? Container(
                        constraints: BoxConstraints(
                          maxWidth: size.width * 0.3,
                          maxHeight: size.height * 0.48,
                        ),
                        child: Image.memory(
                          webImage,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Container(
                        constraints: BoxConstraints(
                          maxWidth: size.width * 0.3,
                          maxHeight: size.height * 0.48,
                        ),
                        child: Image.file(
                          _pickedImage!,
                          fit: BoxFit.contain,
                        ),
                      )),
      ),
    );
  }

  Widget _noPickedImageYet() {
    Size size = Utils(context).getScreenSize;
    return InkWell(
        onTap: () {
          _pickImage();
        },
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s12),
              color: Theme.of(context).cardColor,
            ),
            child: ImageNetwork(
              image: imageUrl!,
              height: size.height * 0.25,
              width: size.width * 0.28,
              fitWeb: BoxFitWeb.contain,
            ),
          ),
        ));
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        GlobalMethods.errorDialog(
            title: "Please Try Again To Upload Image", context: context);
      }
    } else if (kIsWeb) {
      final ImagePicker picker0 = ImagePicker();
      XFile? image = await picker0.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selectedImage = await image.readAsBytes();
        setState(() {
          webImage = selectedImage;
          _pickedImage = File('a');
        });
      } else {
        GlobalMethods.errorDialog(
            title: "Please Try Again To Upload Image", context: context);
      }
    } else {
      GlobalMethods.errorDialog(title: "Try Again Later", context: context);
    }
  }

  @override
  void dispose() {
    productTitleTextController.dispose();
    productDescriptionTextController.dispose();
    productPriceTextController.dispose();
    productSalePriceTextController.dispose();
    super.dispose();
  }
}
