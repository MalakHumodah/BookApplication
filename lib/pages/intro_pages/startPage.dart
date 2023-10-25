import 'package:flutter/material.dart';

import '../../router/constant_router.dart';


class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  Color c2 = Color(0xCD6159e6); // purple
  Color c1 = Color(0xCD34325e); // dark blue
  Color c3 = Color(0xCDf0f0ff); // white


  List<Widget> slides = items
      .map((item) => Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Image.asset(
              item['image'],
              fit: BoxFit.fitWidth,
              width: 220.0,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text(
                    item['description'],
                    style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 1.2,
                        fontSize: 16.0,
                        height: 1.3),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ))).toList();

  List<Widget> indicator() => List<Widget>.generate(
      slides.length,
          (index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 3.0),
        height: 10.0,
        width: 10.0,
        decoration: BoxDecoration(
            color: currentPage.round() == index
                ? Color(0XFF256075)
                : Color(0XFF256075).withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.0)),
      ));

  double currentPage = 0.0;
  final _pageViewController = PageController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageViewController,
            itemCount: slides.length,
            itemBuilder: (BuildContext context, int index) {
              _pageViewController.addListener(() {
                setState(() {
                  currentPage = _pageViewController.page!;
                });
              });
              return slides[index];
            },
          ),
          Padding(
            padding:  EdgeInsets.only(top: height*1.5/3),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 70.0),
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicator(),
                  ),
                ),
                SizedBox(height: 60,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(200, 60),
                        backgroundColor: c1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.of(context).pushNamed(welcomePage);
                    },
                    child: Text(
                      'GetStarted',
                      style: TextStyle(fontSize: 25, color: c3),
                    )),

              ],
            ),
          ),

        ],
      ),
    );
  }
}



///List Of Items
List items = [
  {
    "description":
    "The easiest way to find the best book",
    "image": "assets/Imgs/img1.png"
  },
  {
    "description":
    "Get your new book with the best price",
    "image": "assets/Imgs/pic4.jpeg"
  },
  {
    "description":
    "All of your favorite books are already here",
    "image": "assets/Imgs/images.jpg"
  }
];
