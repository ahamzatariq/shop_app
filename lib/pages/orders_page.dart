import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/shop_drawer.dart';

class OrdersPage extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  var _isLaoding = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (_) async {
        setState(() {
          _isLaoding = true;
        });
        await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
        setState(() {
          _isLaoding = false;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: ShopDrawer(),
      body: _isLaoding
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) =>
                  OrderItem(orderData.orders[index]),
              itemCount: orderData.orders.length,
            ),
    );
  }
}
