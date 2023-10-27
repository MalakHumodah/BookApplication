import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/FireBase/real_time_dataBase/post_model.dart';
import 'package:myapp/state_management/Provider/Models/real_time_post_provider.dart';
import 'package:provider/provider.dart';

import '../../router/constant_router.dart';

class GetPosts extends StatefulWidget {
  const GetPosts({Key? key}) : super(key: key);

  @override
  State<GetPosts> createState() => _GetPostsState();
}

class _GetPostsState extends State<GetPosts> {
  PostList? postList;

  @override
  Widget build(BuildContext context) {
    var postProvider = Provider.of<PostProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Get post page'),
          automaticallyImplyLeading: true,
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(sellBooksPage);
                },
                child: Row(
                  children: const [Icon(Icons.add_box),SizedBox(width: 5,),Text('Add Post'), ],
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
              log('postList!.posts.isEmpty');
              return Center(
                child: RichText(
                    text: TextSpan(text: 'No Post Yet', children: [
                  TextSpan(
                      text: 'Add Post',
                      recognizer: TapGestureRecognizer()..onTap!()),
                ])),
              );
            }
            return ListView.builder(
              itemCount: postList!.posts.length,
              itemBuilder: (context, index) {
                var item = postList!.posts[index];
                return MyWidgetPost(
                    onTap: () {},
                    title: item.title!,
                    price: item.price!,
                    date: item.date!,
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
      required this.date,
      required this.author,
      required this.condition,
      required this.address})
      : super(key: key);
  final VoidCallback onTap;
  final String title;
  final int price;
  final String date;
  final String author;
  final String condition;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Column(
          children: [
            Text(author),
            Text(condition),
            Text(address),
            Text(date),
          ],
        ),
        trailing: Text('$price'),
        onTap: onTap,
      ),
    );
  }
}
