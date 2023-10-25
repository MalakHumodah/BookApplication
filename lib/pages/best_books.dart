import 'package:flutter/material.dart';
import 'package:myapp/JSON/models/book_model.dart';
import 'package:myapp/JSON/services/book_service.dart';

class BestBooks extends StatefulWidget {
  const BestBooks({Key? key}) : super(key: key);

  @override
  State<BestBooks> createState() => _BestBooksState();
}

class _BestBooksState extends State<BestBooks> {
  final BookService _service = BookService();
  BooksList? booksList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top 10 books in 2023')),
      body: FutureBuilder(
          future: _service.loadBooksData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              booksList = snapshot.data;
              return ListView.separated(
                  itemBuilder: (context, int index) {
                    var book = booksList?.books[index];
                    return MyWidget(
                        title: book!.title!,
                        author: book.author!,
                        description: book.description!,
                        img: book.img!,
                        type: book.type!);
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: booksList!.books.length);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({
    Key? key,
    required this.title,
    required this.author,
    required this.description,
    required this.img,
    required this.type,
  }) : super(key: key);

  final String title;
  final String img;
  final String type;
  final String description;
  final String author;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: 'hero-rectangle',
        child: Image.asset(
          img,
          height: 200,
          width: 50,
        ),
      ),
      onTap: () => _gotoDetailsPage(context),
      title: Text(title),
    );
  }

  void _gotoDetailsPage(BuildContext context) {
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
  }
}

Widget MyText({required String txt, required String data}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '$txt : ',
        style: TextStyle(
          fontSize: 20,
          color: Colors.deepPurple,
          letterSpacing: 2.5,
          textBaseline: TextBaseline.alphabetic,
            fontWeight: FontWeight.w500

        ),
        children:[
          TextSpan(text: data, style: TextStyle(
            fontSize: 20,
            color: Colors.deepPurple.shade300,
            letterSpacing: 2.5,
            textBaseline: TextBaseline.alphabetic,
          ),),
        ],
      ),
    )
  );
}




