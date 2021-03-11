import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_pro/models/product_manager.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Produtos'),
        centerTitle: true,
      ),
      body: Consumer<ProductManager>(
        builder: (_,productManager,__){
          return ListView.builder(
            itemCount: productManager.allProducts.length ,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(productManager.allProducts[index].name),
              );
            });
        } ,
      ),
    );
  }
}
