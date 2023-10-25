import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/book_model.dart';

class BookService{
Future<String> _loadJsonFromAssets() async{
  return await rootBundle.loadString('assets/JSONs/books.json');
}
Future<BooksList> loadBooksData() async{
  //string -> job/map
  var decodedData = json.decode(await _loadJsonFromAssets());
  //map -> list
  var model = BooksList.fromJson(decodedData);
  return model;

}
}