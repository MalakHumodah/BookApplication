import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../FireBase/firebase_cloud/cloud_post_service.dart';
import '../../../FireBase/firebase_cloud/cloud_posts_model.dart';
import '../../SharedPref/shared_pref.dart';

class CloudPostProvider extends ChangeNotifier {
  final CloudPostService _postService = CloudPostService();

//because we want to change data so every fun in the service we need to build change data for it

  Future<void> addPost(CloudPostsModel model) async {
    await _postService.addPost(model).whenComplete(() {
      log("adding post from PostProvider is done");
    }).catchError((error) {
      log("Error in PostProvider class in when adding post process and the error is : $error");
    });
    notifyListeners();
  }

  Future<PostList> getPost() async {
    log("get post from provider page is done");
    return await _postService.getPosts();
  }

  PostList get offlinePosts {
    List<CloudPostsModel> postList = [];
    //get --> null
    var data = Prefs.getStringList('postsData') ?? [];
    if (data.isNotEmpty) {
      //convert list of strings --> model -- add model list -- send Post List
      for (var item in data) {
        var decodeData = json.decode(item);
        CloudPostsModel model = CloudPostsModel.fromJson(decodeData);
        postList.add(model);
      }
      return PostList(posts: postList);
    } else {
      return PostList(posts: []);
    }
  }




  Future<void> updatePost(String id, CloudPostsModel model) async {
    await _postService.updatePost(id, model).whenComplete(() {
      refreshPrefs();
      notifyListeners();
    }).catchError((e) {
      log("Update post --> $e");
    });
    //BACK
  }

  Future<void> deletePost(String id) async {
    await _postService.deletePost(id).whenComplete(() {
      refreshPrefs();
      notifyListeners();
    }).catchError((e) {
      log("Delete Post --> $e");
    });
  }

  CloudPostsModel getPostById(String id) {
    var model = offlinePosts.posts.singleWhere((element) {
      if (element.id == id) {
        return true;
      }
      return false;
    });
    return model;
  }

  void refreshPrefs() async {
    await Prefs.remove('postsData');
    String encodeData = '';
    List<String> posts = [];
    PostList postList = await _postService.getPosts(); //get all data
    for (var item in postList.posts) {
      encodeData = json.encode(item.toJson());
      posts.add(encodeData);
    }
    Prefs.setStringList('postsData', posts);
  }





}
