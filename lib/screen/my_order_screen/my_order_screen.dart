import 'package:e_commerce_flutter/models/api_response.dart';
import 'package:e_commerce_flutter/models/order.dart';
import 'package:e_commerce_flutter/models/user.dart';
import 'package:e_commerce_flutter/utility/snack_bar_helper.dart';

import '../../core/data/data_provider.dart';
import '../tracking_screen/tracking_screen.dart';
import '../../utility/app_color.dart';
import '../../utility/extensions.dart';
import '../../utility/utility_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../widget/order_tile.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch orders when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.dataProvider.getAllOrderByUser(context.userProvider.getLoginUsr());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Orders",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.darkOrange),
        ),
      ),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          return ListView.builder(
            itemCount: dataProvider.orders.length,
            itemBuilder: (context, index) {
              final order = dataProvider.orders[index];
              return OrderTile(
                paymentMethod: order.paymentMethod ?? '',
                items: order.items != null && order.items!.isNotEmpty
                    ? '${order.items!.first.productName ?? ''} ${order.items!.length > 1 ? '& ${order.items!.length - 1} Items' : ''}'
                    : 'No Items',
                date: order.orderDate ?? '',
                status: order.orderStatus ?? 'pending',
                onTap: () {
                  if (order.orderStatus == 'shipped') {
                    Get.to(TrackingScreen(url: order.trackingUrl ?? ''));
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
