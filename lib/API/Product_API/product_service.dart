import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:myapp/API/Product_API/product_model.dart';

class ProductService {
  //1 load

  Future<String> _loadData() async {
    var url =
    Uri.parse("https://my.api.mockaroo.com/books.json?key=3c803bb0");

    var response = await http.get(url);

    // s , b
    if (response.statusCode == 200) {
      log("${response.statusCode}");
      return response.body;
    }
    return "";
  }

  Future<ProductsList> getProductsData() async {
    var data = await _loadData();
    if (data.isEmpty) {
      return ProductsList(products: []);
    }

    var decodedData = json.decode(data);
    var list = ProductsList.fromJson(decodedData);
    return list;
  }
}