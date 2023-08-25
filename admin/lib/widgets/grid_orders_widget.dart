import 'package:admin_panel/widgets/orders_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../resources/values_manager.dart';
import '../responsive.dart';
import '../services/utils.dart';

class GridOrdersWidget extends StatelessWidget {
  const GridOrdersWidget({super.key, required this.isMain});

  final bool isMain;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('orders').snapshots(),
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
                itemCount: snapshot.data!.docs.length > 4
                    ? isMain
                        ? 4
                        : snapshot.data!.docs.length
                    : snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: calculateAspectRatio(context),
                  crossAxisSpacing: AppConstants.defaultPadding,
                  mainAxisSpacing: AppConstants.defaultPadding,
                ),
                itemBuilder: (context, index) {
                  return OrderCardWidget(
                    orderId: snapshot.data!.docs[index]['orderId'],
                  );
                });
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: Text('No Orders Yet'),
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
      return size.width < 1400 ? 4.9 : 6.6;
    } else if (Responsive.isTablet(context)) {
      return size.width < 950 ? 5.9 : 6.8;
    } else {
      return 3.1;
    }
  }
}
