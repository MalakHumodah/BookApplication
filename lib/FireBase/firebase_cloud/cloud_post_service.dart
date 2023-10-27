import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'cloud_posts_model.dart';

class CloudPostService {
  final _fireStore = FirebaseFirestore.instance; //to access
  final String collectionName = 'Posts';

  ///Add Post fun
  Future<void> addPost(CloudPostsModel model) async {
    //convert the obj(model) to map by toJson Function
    await _fireStore
        .collection(collectionName)
        .add(model.toJson())
        .whenComplete(() => log("Adding Cloud Post Is Done"))
        .catchError((e) {
      log("Something Wrong Happened in cloudPostService(addPost) :  $e ");
    });
  }

  ///get Post fun
  Future<PostList> getPosts() async {
    //get return query snapshot and it's contain multi objects but i need the docs and the docs return items (list of posts)
    //then we get the data from each item then save it in the map then convert this map to model by fromJson fun then add each
    //model to the list of models then return this list of model

    QuerySnapshot querySnapshot = await _fireStore
        .collection(collectionName)
        .orderBy('id')
        .get()
        .whenComplete(() => log("Getting Post Is Done"))
        .catchError((e) {
      log("Something Wrong Happened $e ");
    });
    //temp map --> item <- from json
    var tempMap = <String, dynamic>{};
    CloudPostsModel tempModel;
    List<CloudPostsModel> posts = [];
    for (var item in querySnapshot.docs) {
      tempMap['id'] = item.get('id');
      tempMap['title'] = item.get('title');
      tempMap['author'] = item.get('author');
      tempMap['type'] = item.get('type');
      tempMap['summary'] = item.get('summary');
      tempModel = CloudPostsModel.fromJson(tempMap);
      posts.add(tempModel);
    }

    return PostList(posts: posts);
  }

  ///update post
  Future<void> updatePost(String id, CloudPostsModel model) async {
    /// 1. search post using string id or any other field identifier in the post model
    // we can use any other field instead of id
    QuerySnapshot querySnapshot = await _fireStore
        .collection(collectionName)
        .where('id', isEqualTo: id)
        .get()
        .whenComplete(() => log("Adding Cloud Post Is Done"))
        .catchError((e) =>
            // ignore: invalid_return_type_for_catch_error
            log('Something Wrong Happened in cloudPostService(updatePost) :  $e '));
    String docId = querySnapshot.docs[0]
        .id; //already the array has just one item because the id is unique
    ///change real id step 2
    // now I got the right post so I can change
    await _fireStore
        .collection(collectionName)
        .doc(docId)
        .update(model.toJson())
        .whenComplete(() => log("Update Post Is Done"))
        .catchError((e) {
      log("Something Wrong Happened $e ");
    });
  }

  ///delete Post
  Future<void> deletePost(String id) async {
    QuerySnapshot querySnapshot = await _fireStore
        .collection(collectionName)
        .where('id', isEqualTo: id)
        .get();
    String docId = querySnapshot.docs[0].id;

    await _fireStore
        .collection(collectionName)
        .doc(docId)
        .delete()
        .whenComplete(() => log("Deleting Post Is Done"))
        .catchError((e) {
      log("Something Wrong Happened $e ");
    });
  }

  /// get Post By Id
  Future<CloudPostsModel> getPostById(String id) async {
    QuerySnapshot querySnapshot = await _fireStore
        .collection(collectionName)
        .where('id', isEqualTo: id)
        .get();

    //the id will only correspond to one id

    //same as get post function but instead of get all posts(for loop) we want certain post
    var tempMap = <String, dynamic>{};
    var item = querySnapshot.docs[0];
    tempMap['id'] = item.get('id');
    tempMap['title'] = item.get('title');
    tempMap['author'] = item.get('author');
    tempMap['type'] = item.get('type');
    tempMap['summary'] = item.get('summary');
    return CloudPostsModel.fromJson(tempMap);
  }
}
