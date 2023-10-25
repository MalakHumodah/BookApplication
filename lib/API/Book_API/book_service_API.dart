import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:myapp/API/Book_API/book_model_API.dart';

class BookService1 {
  //1 load

  Future<String> _loadData() async {
    try {
      var url =
      Uri.parse("https://www.googleapis.com/books/v1/volumes?q=flowers+inauthor:keyes&key=AIzaSyA_Pcft9WgDPGG5hWklzVL9DfC4gCkJrJ4");

      var response = await http.get(url);

      // s , b
      if (response.statusCode == 200) {
        log("${response.statusCode}");
        return response.body;
      }
    }
    catch (e) {
      log(e.toString());}
    return "";
  }

  Future<BookModel> getBooksData() async {
    BookModel model=BookModel();
    var data = await _loadData();
    if (data.isEmpty) {
      return BookModel.fromJson2({});
    }

    var decodedData = json.decode(data);
    log('decodedData is done(BookService)');
    try{
    model=  BookModel.fromJson2(decodedData);
    }catch(e){log(e.toString());}
    return model;


  }




}

  /*Future<BookList> getBooksData() async {
    var data = await _loadData();
    if (data.isEmpty) {
      log('data empty');
      return BookList(books: []);
    }

    var decodedData = json.decode(data);
    log('decodedData is done(BookService)');

    // Check if decodedData is a list, if not, handle it accordingly.
    if (decodedData is List) {
      var list;
      try {
        list = BookList.fromJson(decodedData);
        log('list of data is done(BookService)');
      } catch (e) {
        log(e.toString());
      }
      return list;
    } else {
      // Handle the case where decodedData is not a List.
      // You can return an empty list or throw an exception based on your requirements.
      log('decodedData is not a List');
      return BookList(books: []);
    }}
  }*/


