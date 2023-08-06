import 'package:admin_panel/resources/values_manager.dart';
import 'package:flutter/material.dart';
import '../resources/strings_manager.dart';
import '../services/utils.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildScreenWidget(context);
  }

  Widget _buildScreenWidget(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final textColor = Utils(context).textColor;

    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Material(
        borderRadius: BorderRadius.circular(AppSize.s12),
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSize.s12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Image.network(
                        'https://th.bing.com/th/id/R.d88fba714d703a2dd63d86f2d155acb0?rik=%2f6lrY7GuFxHQLQ&riu=http%3a%2f%2fpluspng.com%2fimg-png%2ftv-hd-png-km0255uhd-0-png-km0255uhd-1-png-1200.png&ehk=KaPoTFpWXYJo7OmaUEsSkxB4eDIQDcPIYJArJ4AegBg%3d&risl=&pid=ImgRaw&r=0',
                        fit: BoxFit.fill,
                        // width: screenWidth * 0.12,
                        height: size.width * 0.12,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {},
                                value: 1,
                                child: Text(AppStrings.edit),
                              ),
                              PopupMenuItem(
                                onTap: () {},
                                value: 2,
                                child: Text(
                                  AppStrings.delete,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ])
                  ],
                ),
                const SizedBox(
                  height: AppSize.s2,
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Text(
                        '\$11000.0',
                        style:
                            TextStyle(color: textColor, fontSize: AppSize.s18),
                      ),
                      const SizedBox(
                        width: AppSize.s8,
                      ),
                      Visibility(
                          visible: true,
                          child: Text(
                            '\$12000.0',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: textColor),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s2,
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    "Samsung Smart TV",
                    style: TextStyle(
                      color: textColor,
                      fontSize: AppSize.s24,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
