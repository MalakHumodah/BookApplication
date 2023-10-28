import 'dart:developer';

import 'package:flutter/material.dart';

import '../API/search_book_API/search_model.dart';
import '../API/search_book_API/search_service.dart';

class AllBooksPage extends StatefulWidget {
  const AllBooksPage({Key? key}) : super(key: key);

  @override
  State<AllBooksPage> createState() => _AllBooksPageState();
}

class _AllBooksPageState extends State<AllBooksPage> {
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
            model = snapshot.data as SearchModel;
            log('model!.results!.length : ${model!.results!.length}');
            //PostItem(model: model!.results![index])
            return ListView.builder(
                itemBuilder: (context,index) {
                  return PostItem(model: model!.results![index]);
                },
              itemCount: model!.results!.length,
            );
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

class PostItem extends StatelessWidget {
  const PostItem({Key? key, required this.model}) : super(key: key);
  final Results model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        height: 300,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.indigoAccent.shade100,
            border: Border.all(color: Colors.indigoAccent)),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.title}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PlayfairDisplay'),
              ),
              Text('by ${model.author}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'PlayfairDisplay')),
              SizedBox(
                height: 25,
              ),
              Text('des : ${model.year}',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400, fontFamily: 'Dosis'
                  )),
              SizedBox(height: 15,),
              Text('pdf Link :  ${model.pdfLink}',
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Dosis')),
            ],
          ),
        ),
      ),
    );
  }
}

class MyWidgetPost extends StatelessWidget {
  const MyWidgetPost({Key? key,
    required this.onTap,
    required this.title,
    required this.id,
    required this.author,
    required this.summary,
    required this.type})
      : super(key: key);
  final VoidCallback onTap;
  final String title;
  final String id;
  final String author;
  final String summary;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Column(
          children: [
            Text(author),
            Text(summary),
            Text(type),
            Text(id),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
