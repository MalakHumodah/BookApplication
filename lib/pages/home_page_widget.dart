import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myapp/JSON/models/book_model.dart';
import '../JSON/services/book_service.dart';
import '../router/constant_router.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final BookService _service = BookService();
  BooksList? booksList;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _service.loadBooksData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          booksList = snapshot.data;
          return CustomScrollView(
            slivers: [
              ///Best Books in 2023 Text
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15.0, top: 18, left: 17),
                  child: Text(
                    'Best Books in 2023',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'PlayfairDisplay',
                    ),
                  ),
                ),
              ),

              ///Horizontal ListView contain MyWidget
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 400, // Set the height of the horizontal list
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // Set the scroll direction
                    itemCount: booksList!.books.length,
                    itemBuilder: (context, index) {
                      var book = booksList?.books[index];
                      return MyWidget(
                        title: book!.title!,
                        img: book.img!,
                        type: book.type!,
                        author: book.author!,
                        description: book.description!,
                      );
                    },
                  ),
                ),
              ),

              ///Divider
              SliverToBoxAdapter(
                child: Divider(thickness: 3),
              ),

              /// My Card 1
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: MyCards(
                    txt: 'Buy/Sell old books',
                    img: 'assets/Imgs/BuySellYourBook.png',
                    color: Colors.amber,
                    title: 'Buy/sell',
                    onTap: () {
                      Navigator.of(context).pushNamed(buyPostsPage);
                    },
                  ),
                ),
              ),

              /// My Card 2
              SliverToBoxAdapter(
                child: MyCards(
                  txt: 'Share your review of your favourite book',
                  img: 'assets/Imgs/shareBook.webp',
                  color: Colors.deepPurpleAccent,
                  title: 'Share',
                  onTap: () {
                    Navigator.of(context).pushNamed(reviewPostsPage);
                  },
                ),
              ),

              /// My Card 3
              SliverToBoxAdapter(
                child: MyCards(
                  txt: 'search about your fav Book',
                  img: 'assets/Imgs/searchBook.png',
                  color: Colors.blueAccent,
                  title: 'Search',
                  onTap: () {
                    //Navigator.of(context).pushNamed(buyBooksPage);
                  },
                ),
              ),

              ///Sized Box
              SliverToBoxAdapter(
                child: SizedBox(height: 50),
              ),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class MyCards extends StatelessWidget {
  MyCards({
    Key? key,
    required this.txt,
    required this.img,
    required this.color,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String txt;
  final String title;
  final String img;
  final Color color;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 300,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: color,
              border: Border.all(
                color: Colors.transparent,
              )),

          /// img and 2 Text in colmun
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20),
                child: Container(
                    height: 170,
                    width: 170,
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Image.asset(
                      img,
                      fit: BoxFit.fill,
                    )),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      txt,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({
    Key? key,
    required this.title,
    required this.img,
    required this.type,
    required this.author,
    required this.description,
  }) : super(key: key);

  final String title;
  final String img;
  final String type;
  final String description;
  final String author;

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => _gotoDetailsPage(context),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5),
                child: Text(
                  type,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: data,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple.shade300,
                  letterSpacing: 2.5,
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
            ],
          ),
        ));
  }
}
