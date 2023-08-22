import 'package:admin_panel/widgets/product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../resources/values_manager.dart';
import '../responsive.dart';
import '../services/utils.dart';

class GridProductsWidget extends StatelessWidget {
  const GridProductsWidget({super.key, required this.isMain});
  final bool isMain;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data!.docs.isNotEmpty) {
            return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: isMain ? 4 : snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
                  childAspectRatio: calculateAspectRatio(context),
                  crossAxisSpacing: AppConstants.defaultPadding,
                  mainAxisSpacing: AppConstants.defaultPadding,
                ),
                itemBuilder: (context, index) {
                  return ProductWidget(
                    productId: snapshot.data!.docs[index]['id'],
                  );
                });
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Text('Your store is empty'),
              ),
            );
          }
        }
        return const Center(
          child: Text(
            'Something went wrong',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        );
      },
    );
  }

  double calculateAspectRatio(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    if (Responsive.isDesktop(context)) {
      return size.width < 1400 ? 0.96 : 1;
    } else if (Responsive.isTablet(context)) {
      return size.width < 950 ? 1.4 : 1.3;
    } else {
      return 1.1;
    }
  }
}
