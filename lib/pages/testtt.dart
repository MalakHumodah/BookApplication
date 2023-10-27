import 'package:flutter/material.dart';

/// Flutter code sample for [showModalBottomSheet].

class CloudPosts extends StatefulWidget {
  const CloudPosts({Key? key}) : super(key: key);

  @override
  State<CloudPosts> createState() => _CloudPostsState();
}

class _CloudPostsState extends State<CloudPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: StreamBuilder(
        stream: postProvider.getPosts().asStream(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data == null) {
            return Center(child: CircularProgressIndicator());
          }

          postList = data as PostList;
          if (postList!.posts.isEmpty) {
            //button click add
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
                              Navigator.of(context).pushNamed(addPostRoute);
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
                  subtitle: item.subtitle!,
                  image: item.image!,
                  date: DateTime.parse(item.date!),
                  onTap: () {
                    // navigation edit post
                    Navigator.of(context)
                        .pushNamed(editPostRoute, arguments: item.id);
                  });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(addPostRoute);
        },
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  const PostItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.image,
      required this.date,
      required this.onTap})
      : super(key: key);
  final String title;
  final String subtitle;
  final String image;
  final DateTime date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        subtitle: Column(
          children: [Text(subtitle), Divider(), Image.network(image)],
        ),
        trailing: Text(
            DateFormat.yMd().format(date)), //dateTime -> String // 2020-05-01
      ),
    );
  }
}
