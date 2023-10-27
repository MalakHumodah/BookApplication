import 'package:flutter/foundation.dart';

class PostModel extends ChangeNotifier{
  String? id;
  String? title;
  String? date;
  String? condition;
  String? author;
  String? address;
  int? price;

  PostModel(
      {this.id,
        this.title,
        this.date,
        this.condition,
        this.author,
        this.address,
        this.price});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    condition = json['condition'];
    author = json['author'];
    address = json['address'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['date'] = date;
    data['condition'] = condition;
    data['author'] = author;
    data['address'] = address;
    data['price'] = price;
    return data;
  }
}

class PostList {
  List<PostModel> posts;

  PostList({required this.posts});

  factory PostList.fromJson(List<dynamic> data) {
    List<PostModel> dataList = [];
    dataList = data.map((item) {
      return PostModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();
    return PostList(posts: dataList);
  }
}

class CloudPostsModel {
  String? id;
  String? title;
  String? author;
  String? type;
  String? summary;

  CloudPostsModel({this.id, this.title, this.author, this.type, this.summary});

  CloudPostsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    type = json['type'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['type'] = type;
    data['summary'] = summary;
    return data;
  }
}


/*class PostList {
  List<CloudPostsModel> posts;

  PostList({required this.posts});

  factory PostList.fromJson(List<dynamic> data) {
    List<CloudPostsModel> dataList = [];
    dataList = data.map((item) {
      return CloudPostsModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();
    return PostList(posts: dataList);
  }
}*/






//*******************************
/*import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';


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
*/