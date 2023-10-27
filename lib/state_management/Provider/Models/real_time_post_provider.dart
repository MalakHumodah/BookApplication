import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:myapp/FireBase/real_time_dataBase/post_model.dart';
import 'package:myapp/FireBase/real_time_dataBase/post_service.dart';

import '../../SharedPref/shared_pref.dart';

class PostProvider extends ChangeNotifier {
  final PostService _postService = PostService();

//because we want to change data so every fun in the service we need to build change data for it

  Future<void> addPost(PostModel model) async {
    await _postService.addPost(model).whenComplete(() {
      log("adding post from PostProvider is done");
    }).catchError((error) {
      log("Error in PostProvider class in when adding post process and the error is : $error");
    });
    notifyListeners();
  }

  Future<PostList> getPost() async {
    log("get post from provider page is done");
    return await _postService.getPost();
  }

  PostList get offlinePosts {
    List<PostModel> postList = [];
    //get --> null
    var data = Prefs.getStringList('postsData') ?? [];
    if (data.isNotEmpty) {
      //convert list of strings --> model -- add model list -- send Post List
      for (var item in data) {
        var decodeData = json.decode(item);
        PostModel model = PostModel.fromJson(decodeData);
        postList.add(model);
      }
      return PostList(posts: postList);
    } else {
      return PostList(posts: []);
    }
  }




  Future<void> updatePost(String id, PostModel model) async {
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

  PostModel getPostById(String id) {
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
    PostList postList = await _postService.getPost(); //get all data
    for (var item in postList.posts) {
      encodeData = json.encode(item.toJson());
      posts.add(encodeData);
    }
    Prefs.setStringList('postsData', posts);
  }

  



  }


//The provider will be the link between the service and the pages(UI)
// Data source, application the link between them => service
// Service, pages(UI) => provider (because we need state management link the UI with Posts)