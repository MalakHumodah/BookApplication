import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:myapp/API/search_book_API/search_model.dart';
class SearchService {
  _loadData() async {
    var headers = {
      'X-RapidAPI-Key': '2154944489mshcfc638b35eabdf7p14de83jsna28b2c83ab14',
      'X-RapidAPI-Host': 'getbooksinfo.p.rapidapi.com',
    };
    var url =
        Uri.parse('https://getbooksinfo.p.rapidapi.com/?s=%3CREQUIRED%3E');
  var response = await http.get(url,headers: headers);
    if (response.statusCode == 200) {
      var responseBody = response.body;
      //log(responseBody);
      log('successful response');
      return responseBody;
      // Handle successful response
    } else {
      log('error response');
      // Handle error response
    }
  }

  Future<SearchModel> getData() async{
    var data = await _loadData();
    if (data.isEmpty) {
      return SearchModel.fromJson({});
    }
    var decodedData = json.decode(data);
    return SearchModel.fromJson(decodedData);
  }

  }

