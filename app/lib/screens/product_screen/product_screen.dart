import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/widgets/heart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../resources/values_manager.dart';
import '../../services/utils.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    final Color textColor = Utils(context).textColor;
    Size size = Utils(context).screenSize;

    return CustomScrollView(slivers: [
      SliverAppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(AppIcons.leftArrow)),
        iconTheme: IconThemeData(color: textColor, size: AppSize.s22),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: IconButton(
              icon: const Icon(
                AppIcons.share,
                size: AppSize.s30,
              ),
              onPressed: () {},
            ),
          )
        ],
        expandedHeight: size.height * 0.6,
        elevation: AppSize.s0,
        snap: true,
        floating: true,
        stretch: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
            ],
            background: Image.network(
              'https://th.bing.com/th/id/R.d88fba714d703a2dd63d86f2d155acb0?rik=%2f6lrY7GuFxHQLQ&riu=http%3a%2f%2fpluspng.com%2fimg-png%2ftv-hd-png-km0255uhd-0-png-km0255uhd-1-png-1200.png&ehk=KaPoTFpWXYJo7OmaUEsSkxB4eDIQDcPIYJArJ4AegBg%3d&risl=&pid=ImgRaw&r=0',
              fit: BoxFit.fill,
              width: size.width * 0.2,
              height: size.height * 0.12,
            )),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(AppSize.s45),
            child: Transform.translate(
              offset: const Offset(AppSize.s0, AppSize.s1),
              child: Container(
                height: AppSize.s45,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSize.s30),
                    topRight: Radius.circular(AppSize.s30),
                  ),
                ),
                child: Center(
                    child: Container(
                  width: AppSize.s50,
                  height: AppSize.s8,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(AppSize.s10),
                  ),
                )),
              ),
            )),
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        Container(
            height: size.height,
            color: Theme.of(context).cardColor,
            // padding: const EdgeInsets.symmetric(
            //     horizontal: AppSize.s20, vertical: AppSize.s5),
            child: Column(
              children: [
                const SizedBox(
                  height: AppSize.s35,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p20, vertical: AppPadding.p5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Samsung Smart TV",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppSize.s24),
                        ),
                      ),
                      HeartButton()
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20, vertical: AppPadding.p5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            const TextSpan(
                              text: '\$11000.0',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: AppSize.s24,
                                // Adjust the font size as needed
                              ),
                            ),
                            TextSpan(
                              text: "/${AppStrings.piece}",
                              style: TextStyle(
                                color: textColor,
                                fontSize: AppSize
                                    .s20, // Adjust the font size as needed
                              ),
                            ),
                          ],
                        ),
                      )),
                      Material(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: Text(
                            AppStrings.freeShipping,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: AppSize.s15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                SizedBox(
                  width: size.width * 0.4,
                  child: Row(
                    children: [
                      _quantityController(
                          buttonFunction: () {
                            if (_quantityTextController.text == "1") {
                              return;
                            } else {
                              setState(() {
                                _quantityTextController.text =
                                    (int.parse(_quantityTextController.text) -
                                            1)
                                        .toString();
                              });
                            }
                          },
                          buttonColor: Colors.red,
                          buttonIcon: AppIcons.minus),
                      Flexible(
                        child: TextField(
                          controller: _quantityTextController,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[0-9]'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                _quantityTextController.text = '1';
                              } else {
                                return;
                              }
                            });
                          },
                        ),
                      ),
                      _quantityController(
                          buttonFunction: () {
                            setState(() {
                              _quantityTextController.text =
                                  (int.parse(_quantityTextController.text) + 1)
                                      .toString();
                            });
                          },
                          buttonColor: Colors.green,
                          buttonIcon: AppIcons.add)
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s120,
                ),
                _bottomROw()
              ],
            ))
      ])),
    ]);
  }

  Widget _quantityController(
      {required Function buttonFunction,
      required Color buttonColor,
      required IconData buttonIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.circular(AppSize.s12),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p5),
          child: InkWell(
            onTap: () {
              buttonFunction();
            },
            child: Icon(
              buttonIcon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomROw() {
    final Color textColor = Utils(context).textColor;

    return SizedBox(
      height: AppSize.s120,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSize.s12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p20, vertical: AppPadding.p8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.total,
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSize.s24),
                  ),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        const TextSpan(
                          text: '\$11000.0',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: AppSize.s24,
                            // Adjust the font size as needed
                          ),
                        ),
                        TextSpan(
                          text:
                              "/${_quantityTextController.text}${AppStrings.piece}",
                          style: TextStyle(
                            color: textColor,
                            fontSize:
                                AppSize.s20, // Adjust the font size as needed
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Material(
                color: Colors.green,
                borderRadius: BorderRadius.circular(AppSize.s12),
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Text(
                    AppStrings.addToCart,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: AppSize.s18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }
}
