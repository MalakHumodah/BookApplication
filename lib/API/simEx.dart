import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'Book_API/book_model_API.dart';


class BookService {
  final String baseUrl;

  BookService({required this.baseUrl});

  Future<BookModel?> getBooksData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        log("${response.statusCode}");
        final decodedData = json.decode(response.body);
        return BookModel.fromJson(decodedData);
      } else {
        // Handle HTTP error responses here, if needed.
        // For example, you can throw an exception or return null.
        return null;
      }
    } catch (e) {
      // Handle exceptions here, such as network errors.
      // You can throw an exception or return null.
      return null;
    }
  }
}
