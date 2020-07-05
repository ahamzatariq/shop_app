import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/pages/product_detail_page.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';

class ProductItem extends StatefulWidget {
//  final String id;
//  final String title;
//  final String imageUrl;
//
//  ProductItem({this.id, this.title, this.imageUrl});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  var _cardIconToggle = false;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailPage.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () {
                product.toggleFavoriteStatus();
              },
            ),
          ),
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(_cardIconToggle
                ? Icons.shopping_cart
                : Icons.add_shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              setState(() {
                _cardIconToggle = true;
              });
            },
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
