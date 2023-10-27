import 'package:flutter/material.dart';

import '../JSON/models/book_model.dart';
import '../JSON/services/book_service.dart';

class TopBooks extends StatefulWidget {
  const TopBooks({Key? key}) : super(key: key);

  @override
  State<TopBooks> createState() => _TopBooksState();
}

class _TopBooksState extends State<TopBooks> {
  final BookService _service = BookService();
  BooksList? booksList;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _service.loadBooksData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            booksList = snapshot.data;
            return ListView.separated(
                itemBuilder: (context, int index) {
                  var book = booksList?.books[index];
                  return MyWidget(
                      title: book!.title!, img: book.img!, type: book.type!);
                },
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: booksList!.books.length);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({
    Key? key,
    required this.title,
    required this.img,
    required this.type,
  }) : super(key: key);

  final String title;
  final String img;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 250,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
            border: Border.all(
              color: Colors.transparent,
            )),
        //this column contain img,title and type
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 220,
                  width: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Image.asset(
                    img,
                    fit: BoxFit.fill,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5),
              child: Text(
                type,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }

/*void _gotoDetailsPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Details of the selected book'),
        ),
        body: Center(
          child: Hero(
              tag: 'hero-details',
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Image.asset(
                        img,
                        height: 300,
                        width: 300,
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    MyText(txt: 'Title', data: title),
                    MyText(txt: 'Author', data: author),
                    MyText(txt: 'Type', data: type),
                    MyText(txt: 'Description', data: description),
                  ],
                ),
              )),
        ),
      ),
    ));
  }*/
}

class MyCards extends StatelessWidget {
  const MyCards({
    Key? key,
    required this.txt,
    required this.img,
    required this.color,
    required this.title,
  }) : super(key: key);
  final String txt;
  final String title;
  final String img;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(

        height: 250,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
            border: Border.all(
              color: Colors.transparent,
            )),
        //this column contain img,title and type
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 220,
                  width: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Image.asset(
                    img,
                    fit: BoxFit.fill,
                  )),
            ),
            Text(txt,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),


          ],
        ),
      ),
    );
  }
}
