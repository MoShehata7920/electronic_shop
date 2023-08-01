import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/widgets/feed_items.dart';
import 'package:flutter/material.dart';
import '../../../resources/values_manager.dart';
import '../../../services/utils.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;
    Size size = Utils(context).screenSize;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppStrings.allProducts,
            style: TextStyle(
                color: textColor,
                fontSize: AppSize.s22,
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(AppIcons.leftArrow)),
          iconTheme: IconThemeData(color: textColor, size: AppSize.s22),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  focusNode: _searchTextFocusNode,
                  controller: _searchTextController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          borderSide: const BorderSide(
                              color: Colors.cyan, width: AppSize.s1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          borderSide: const BorderSide(width: AppSize.s1)),
                      hintText: AppStrings.searchText,
                      prefixIcon: const Icon(AppIcons.search),
                      suffix: IconButton(
                        onPressed: () {
                          _searchTextController.clear();
                          _searchTextFocusNode.unfocus();
                        },
                        icon: Icon(
                          AppIcons.close,
                          color: _searchTextFocusNode.hasFocus
                              ? Colors.red
                              : textColor,
                        ),
                      ),
                      iconColor: textColor),
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                childAspectRatio: size.width / (size.height * 0.61),
                children: List.generate(15, (index) {
                  return const FeedWidget();
                }),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }
}
