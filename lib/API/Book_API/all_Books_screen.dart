import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myapp/API/Book_API/book_model_API.dart';
import 'package:myapp/API/Book_API/book_service_API.dart';
import 'package:myapp/API/Book_API/book_widget.dart';


import '../../state_management/SharedPref/user_model.dart';
import '../simEx.dart';

class AllBookScreen extends StatefulWidget {
  const AllBookScreen({Key? key, required this.model}) : super(key: key);
  final  UserModel model;

  @override
  State<AllBookScreen> createState() => _AllBookScreenState();
}

class _AllBookScreenState extends State<AllBookScreen> {
  BookService _service =  BookService(baseUrl: 'https://www.googleapis.com/books/v1/volumes?q=flowers+inauthor:keyes&key=AIzaSyA_Pcft9WgDPGG5hWklzVL9DfC4gCkJrJ4');
  BookModel? books;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('All Books'),

      ),

      body: StreamBuilder(
        stream: _service.getBooksData().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            books = snapshot.data as BookModel;
            log("I'm in AllBookScreen");
            return Center(
                child: Text("My text is ${snapshot.data?.totalItems}" ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

/*GridView.builder(
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemBuilder: (context,index){
                return BookItemView(
                  model: books!.books[index],
                  onTab: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${books!.books[index].kind}')));
                  },
                );
              },
            );*/