import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:myapp/FireBase/real_time_dataBase/post_model.dart';

class PostService {
  //to access to dataBase we need just one instance
  final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  //each function need its own reference so we need to initialize the reference in each function alone
  // here we want to declaration the reference and set the value in each fun so its not final

  DatabaseReference? databaseReference;
  String root = "/";
  String subRoot = "/subRoot";

  ///Add Post
  Future<void> addPost(PostModel model) async {
    databaseReference = firebaseDatabase.ref();
    //to set more than one value we should use map
    //so we need to convert the model to map by using toJson fun
    databaseReference!
        .child(root)
        .child(subRoot)
        .child(model.id!)
        .set(model.toJson())
        .whenComplete(() {
      log("adding post is done and we in the PostService page");
    });
  }

  ///Get Post
  //return PostList
  Future<PostList> getPost() async {
    databaseReference = firebaseDatabase.ref();
    //query is not only the posts ,, everything in realDatabase
    DatabaseEvent query = await databaseReference!
        .child(root)
        .child(subRoot)
        .orderByValue()
        .once();
    //log("Data type is : ${query.snapshot.value.runtimeType}");
    //log("Data is : ${query.snapshot.value}");
    //query.snapshot.value -> [null,{post1},{post2},{post3},...] => list of maps
    //check if we have data ? return list of data : return emptyList
    if (query.snapshot.exists) {
      var postTempList = [];
      var dataMap = query.snapshot.value as Map<dynamic, dynamic>;
      dataMap.forEach((key, value) {
        //list of obj(values)[{},{},{},..]
        postTempList.add(value);
      });
      return PostList.fromJson(postTempList);
    }
      log('empty list in getPost In PostService Page');
      return PostList(posts: []);
    }


    ///Update Post
  Future<void> updatePost(String id, PostModel model) async {
    databaseReference = firebaseDatabase.ref('$root/$subRoot/$id');
    await databaseReference!.update(model.toJson());
  }

  ///Delete Post
  Future<void> deletePost(String id) async {
    databaseReference = firebaseDatabase.ref('$root/$subRoot/$id');
    await databaseReference!.remove();
  }


  }
