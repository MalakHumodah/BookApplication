import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../FireBase/firebase_cloud/buy_sell_posts_model.dart';
import '../../router/constant_router.dart';
import '../../state_management/Provider/Models/buySell_post_provider.dart';

class BuyPostsPage extends StatefulWidget {
  const BuyPostsPage({Key? key}) : super(key: key);

  @override
  State<BuyPostsPage> createState() => _BuyPostsPageState();
}

class _BuyPostsPageState extends State<BuyPostsPage> {
  PostList? postList;

  @override
  Widget build(BuildContext context) {
    var postProvider = Provider.of<BuySellPostProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Old Book Store'),
          automaticallyImplyLeading: true,
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(sellPostPage);
                },
                child: Row(
                  children: const [
                    Icon(Icons.add_box),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Add Post'),
                  ],
                ))
          ],
        ),
        body: StreamBuilder(
          stream: postProvider.getPost().asStream(),
          builder: (context, snapshot) {
            log('snapshot : ${snapshot}');
            var data = snapshot.data;
            if (data == null) {
              return Center(child: CircularProgressIndicator());
            }
            postList = data as PostList;
            if (postList!.posts.isEmpty) {
              log('postList.posts.isEmpty');
              return Center(
                  child: Text(
                'No Posts Yet',
                style: TextStyle(fontSize: 30),
              ));
            }
            return ListView.builder(
              itemCount: postList!.posts.length,
              itemBuilder: (context, index) {
                var item = postList!.posts[index];
                log('date: item.date! : ${item.date}');
                return MyWidgetPost(
                    onTap: () {},
                    title: item.title!,
                    price: item.price!,
                    //date: item.date!,
                    author: item.author!,
                    condition: item.condition!,
                    address: item.address!);
              },
            );
          },
        ));
  }
}

class MyWidgetPost extends StatelessWidget {
  const MyWidgetPost(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.price,
      //required this.date,
      required this.author,
      required this.condition,
      required this.address})
      : super(key: key);
  final VoidCallback onTap;
  final String title;
  final int price;

  //final String date;
  final String author;
  final String condition;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text('$title by $author',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'PlayfairDisplay')),
          subtitle: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(condition,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Dosis')),
                SizedBox(height: 14,),
                Text(address,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Dosis')),
                //Text(date),
              ],
            ),
          ),
          trailing: Text('$price\$',style: TextStyle(fontSize: 25),),
          onTap: onTap,
        ),
      ),
    );
  }
}
