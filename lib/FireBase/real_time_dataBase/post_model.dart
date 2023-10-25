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
/*class PostList {
  List<PostModel> posts;

  PostList({required this.posts});

  factory PostList.fromJson(List<dynamic> data) {
    List<PostModel> dataList = [];
    dataList = data.map((item) {
      return PostModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();
    return PostList(posts: dataList);
  }
}*/
