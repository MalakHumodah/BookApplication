import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import '../../FireBase/firebase_cloud/cloud_posts_model.dart';
import '../../router/constant_router.dart';
import '../../state_management/Provider/Models/cloud_post_provider.dart';

class FireStorePage extends StatefulWidget {
  const FireStorePage({Key? key}) : super(key: key);

  @override
  State<FireStorePage> createState() => _FireStorePageState();
}

class _FireStorePageState extends State<FireStorePage> {
  PostList? postList;

  @override
  Widget build(BuildContext context) {
    var postProvider = Provider.of<CloudPostProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Get Cloud post page'),
          automaticallyImplyLeading: true,
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(addingCloudPostPage);
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
                                    .pushNamed(addingCloudPostPage);
                              })
                      ]),
                ),
              );
            }
            return ListView.builder(
              itemCount: postList!.posts.length,
              itemBuilder: (context, index) {
                var item = postList!.posts[index];
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
  const PostItem(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.author,
      required this.summary,
      required this.type})
      : super(key: key);
  final VoidCallback onTap;
  final String title;
  final String author;
  final String summary;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        subtitle: Column(
          children: [
            Text('Author : $author ,,, Type : $type '),
            Divider(),
            Text(summary),
          ],
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
