import 'package:admin_panel/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import '../resources/values_manager.dart';
import '../services/utils.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: _buildScreenWidget(context)),
        ),
      ),
    );
  }

  Widget _buildScreenWidget(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final textColor = Utils(context).textColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Image.network(
            'https://th.bing.com/th/id/R.d88fba714d703a2dd63d86f2d155acb0?rik=%2f6lrY7GuFxHQLQ&riu=http%3a%2f%2fpluspng.com%2fimg-png%2ftv-hd-png-km0255uhd-0-png-km0255uhd-1-png-1200.png&ehk=KaPoTFpWXYJo7OmaUEsSkxB4eDIQDcPIYJArJ4AegBg%3d&risl=&pid=ImgRaw&r=0',
            fit: BoxFit.fill,
            // width: screenWidth * 0.12,
            height: size.width * 0.12,
          ),
        ),
        const SizedBox(
          width: AppSize.s15,
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              Text(
                "Samsung Smart TV",
                style: TextStyle(
                  color: textColor,
                  fontSize: AppSize.s27,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
              const SizedBox(
                height: AppSize.s15,
              ),
              RichText(
                  text: TextSpan(
                      text: "1${AppStrings.pieceFor}",
                      style: TextStyle(color: textColor, fontSize: AppSize.s18),
                      children:  [
                    TextSpan(
                      text: "11000.0${AppStrings.egyptianPound}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: AppSize.s18,
                      ),
                    ),
                  ])),
              const SizedBox(
                height: AppSize.s15,
              ),
              RichText(
                  text: TextSpan(
                      text:AppStrings.by ,
                      style: const TextStyle(
                          color: Colors.cyan, fontSize: AppSize.s18),
                      children: [
                    TextSpan(
                      text: "Mohamed Shehata",
                      style: TextStyle(
                        color: textColor,
                        fontSize: AppSize.s18,
                      ),
                    ),
                  ])),
              const SizedBox(
                height: AppSize.s15,
              ),
              Text(
                "06/08/2023",
                style: TextStyle(
                    color: textColor,
                    fontSize: AppSize.s18,
                    fontWeight: FontWeight.w100),
              ),
            ],
          ),
        )
      ],
    );
  }
}
