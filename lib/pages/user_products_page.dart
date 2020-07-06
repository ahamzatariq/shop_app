import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/user_product_item.dart';

import '../widgets/shop_drawer.dart';

class UserProductsPage extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      drawer: ShopDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                UserProductItem(
                  productsData.items[index].title,
                  productsData.items[index].imageUrl,
                ),
                Divider(
                  color: Colors.black12,
                ),
              ],
            );
          },
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
