import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quatity;
  final double price;

  CartItem({@required this.id,
    @required this.title,
    @required this.quatity,
    @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(productId, (existingCartItem) =>
          CartItem(id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quatity: (existingCartItem.quatity) + 1));
    }

    else {
      _items.putIfAbsent(productId, () =>
          CartItem(id: DateTime.now().toString(),
              title: title,
              quatity: 1,
              price: price));
    }
  }
}