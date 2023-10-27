import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../FireBase/real_time_dataBase/review_posts_model.dart';
import '../../router/constant_router.dart';
import '../../state_management/Provider/Models/review_post_provider.dart';

class ReviewPostsPage extends StatefulWidget {
  const ReviewPostsPage({Key? key}) : super(key: key);

  @override
  State<ReviewPostsPage> createState() => _ReviewPostsPageState();
}

class _ReviewPostsPageState extends State<ReviewPostsPage> {
  PostList? postList;

  @override
  Widget build(BuildContext context) {
    var postProvider = Provider.of<ReviewPostProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          foregroundColor: Colors.white70,
          title: Text('Overviews'),
          automaticallyImplyLeading: true,
          actions: [
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigoAccent)),
                onPressed: () {
                  Navigator.of(context).pushNamed(addingReviewPostPage);
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
            log('snapshot : $snapshot');
            var data = snapshot.data;
            if (data == null) {
              return Center(child: CircularProgressIndicator());
            }

            postList = data;
            if (postList!.posts.isEmpty) {
              log('postList!.posts.isEmpty');
              return Center(
                child: RichText(
                  text: TextSpan(
                      text: "No Data Yet ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text: 'Add Post',
                            style: TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .pushNamed(addingReviewPostPage);
                              })
                      ]),
                ),
              );
            }
            return ListView.builder(
              itemCount: postList!.posts.length,
              itemBuilder: (context, index) {
                var item = postList!.posts[index];
                log('Item : ${postList!.posts[0]}');
                return PostItem(
                  title: item.title!,
                  author: item.author!,
                  summary: item.summary!,
                  type: item.type!,
                  onTap: () {
                    // navigation edit post
                    //Navigator.of(context).pushNamed(editPostRoute, arguments: item.id);
                  },
                );
              },
            );
          },
        ));
  }
}

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required this.onTap,
    required this.title,
    required this.author,
    required this.summary,
    required this.type
  }) : super(key: key);
  final VoidCallback onTap;
  final String title;
  final String author;

  final String summary;

  final String type;

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
                title,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PlayfairDisplay'),
              ),
              Text('by $author',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'PlayfairDisplay')),
              SizedBox(
                height: 25,
              ),
              Text('My overview about this book : $summary',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,fontFamily: 'Dosis'
                  )),
              SizedBox(height: 10,),
              Text('Rate :  $type',
                  style: TextStyle(
                      fontSize: 20,
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
  const MyWidgetPost(
      {Key? key,
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
