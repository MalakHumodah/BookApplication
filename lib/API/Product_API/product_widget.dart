import 'package:flutter/material.dart';
import 'package:myapp/API/Product_API/product_model.dart';

class ProductItemView extends StatelessWidget {
  const ProductItemView({Key? key, required this.model, required this.onTab})
      : super(key: key);

  final ProductModel model;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Hero(
                tag: 'category${model.id}',
                child: SizedBox(
                  height: 100,
                  child: Image.network(
                    model.image!,
                    fit: BoxFit.cover,
                  ),
                )),
            SizedBox(
              height: 3,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(model.name!.length>10?model.name!.substring(0,10):model.name!,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text(
                  model.description!.length > 30
                      ? model.description!.substring(0, 15)
                      : model.description!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${model.price}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.pink,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
