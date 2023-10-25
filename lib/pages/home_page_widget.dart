import 'package:flutter/material.dart';
import '../router/constant_router.dart';
class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() =>
      _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              switch (index) {
                case 0:
                  {
                    return MyCard(
                        txt: 'Explore',
                        onTap: () {
                          Navigator.of(context).pushNamed(bestBooksScreen);
                        });
                  }
                  break;
                case 1:
                  {
                    return MyCard(
                        txt: 'Buy/Sell',
                        onTap: () {
                          Navigator.of(context).popAndPushNamed(buyBooksPage);
                        });
                  }
                  break;
                case 2:
                  {
                    return MyCard(
                        txt: 'Overviews',
                        onTap: () {
                          //Navigator.of(context).popAndPushNamed(bestBooksScreen);
                        });
                  }
                  break;
                case 3:
                  {
                    return MyCard(
                        txt: 'else',
                        onTap: () {
                          //Navigator.of(context).popAndPushNamed(bestBooksScreen);
                        });
                  }
                  break;
              }
            },
            itemCount: 4,
            scrollDirection: Axis.horizontal,
          ),
        ),
        Divider(),
        Expanded(
          flex: 6,
            child: SizedBox())
      ],
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({Key? key, required this.txt, required this.onTap})
      : super(key: key);
  final String txt;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: Colors.amber,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              txt,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

