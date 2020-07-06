import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class EditProductPage extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  State<StatefulWidget> createState() {
    return _EditProductPageState();
  }
}

class _EditProductPageState extends State<EditProductPage> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState.save();
    print(_editedProduct.title);
    print(_editedProduct.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm;
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
                onSaved: (newValue) {
                  _editedProduct = Product(
                      title: newValue,
                      id: _editedProduct.id,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                      description: _editedProduct.description);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                onSaved: (newValue) {
                  _editedProduct = Product(
                      title: _editedProduct.title,
                      id: _editedProduct.id,
                      price: double.parse(newValue),
                      imageUrl: _editedProduct.imageUrl,
                      description: _editedProduct.description);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (newValue) {
                  _editedProduct = Product(
                      title: _editedProduct.title,
                      id: _editedProduct.id,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                      description: newValue);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black38),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) => _saveForm,
                      onSaved: (newValue) {
                        _editedProduct = Product(
                            title: _editedProduct.title,
                            id: _editedProduct.id,
                            price: _editedProduct.price,
                            imageUrl: newValue,
                            description: _editedProduct.description);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }
}
