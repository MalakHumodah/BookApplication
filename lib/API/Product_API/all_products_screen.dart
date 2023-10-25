import 'package:flutter/material.dart';
import 'package:myapp/API/Product_API/product_model.dart';
import 'package:myapp/API/Product_API/product_service.dart';
import 'package:myapp/API/Product_API/product_widget.dart';

import '../../state_management/SharedPref/user_model.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({Key? key, required this.model}) : super(key: key);
  final  UserModel model;

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {

  ProductService _service = ProductService();
  ProductsList? products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('All Books'),

      ),

      body: StreamBuilder(
        stream: _service.getProductsData().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            products = snapshot.data as ProductsList;
            return GridView.builder(
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemBuilder: (context,index){
                return ProductItemView(
                  model: products!.products[index],
                  onTab: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${products!.products[index].name}')));
                  },
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
