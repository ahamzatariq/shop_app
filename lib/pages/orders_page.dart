import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/shop_drawer.dart';

class OrdersPage extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    print('building orders');
//    final orderData = Provider.of<Orders>(context); this would set a loop while using it with FutureBuilder, instead use a consumer where data is required.
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: ShopDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.error != null) {
                //can do error handling here
                return Center(child: Text('An error occured here!'));
              } else {
                return Consumer<Orders>(
                  builder: (context, orderData, child) => ListView.builder(
                    itemBuilder: (context, index) =>
                        OrderItem(orderData.orders[index]),
                    itemCount: orderData.orders.length,
                  ),
                );
              }
            }
          },
        ));
  }
}
