import 'package:electronic_shop/models/orders_model.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../services/utils.dart';

class OrdersCard extends StatefulWidget {
  const OrdersCard({super.key});

  @override
  State<OrdersCard> createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late String orderDateToShow;

    Size size = Utils(context).screenSize;
    double cardHeight = size.height * 0.13;

    final orderListModel = Provider.of<OrderModel>(context);
    var orderDate = orderListModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productScreenRoute,
          arguments: orderListModel.productId,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.25,
              height: cardHeight,
              child: FancyShimmerImage(
                imageUrl: orderListModel.productImage,
                boxFit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: AppSize.s10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Text(
                          orderListModel.productName,
                          style: const TextStyle(
                            fontSize: AppSize.s16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        width: AppSize.s4,
                      ),
                      Flexible(
                        flex: 2,
                        child: Text(
                          "(${orderListModel.orderedQuantity} PCS)",
                          style: const TextStyle(
                            fontSize: AppSize.s12,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s15),
                  Text(
                    "${AppStrings.paid} ${orderListModel.productTotalPrice}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: AppSize.s14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSize.s10),
            Text(
              orderDateToShow,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
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
