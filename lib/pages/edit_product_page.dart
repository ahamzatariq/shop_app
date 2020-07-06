import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  State<StatefulWidget> createState() {
    return _EditProductPageState();
  }
}

class _EditProductPageState extends State<EditProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
              )
            ],
          ),
        ),
      ),
    );
  }
}
