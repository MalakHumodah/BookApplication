import 'package:flutter/material.dart';
import 'package:myapp/API/search_book_API/search_model.dart';
import 'package:myapp/API/search_book_API/search_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchService searchService = SearchService();
  SearchModel? model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: searchService.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            model=snapshot.data as SearchModel;
            return Center(child: Text('SearchPage'),);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
