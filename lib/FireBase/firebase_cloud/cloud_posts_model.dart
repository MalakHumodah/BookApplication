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


class PostList {
  List<CloudPostsModel> posts;

  PostList({required this.posts});

  factory PostList.fromJson(List<dynamic> data) {
    List<CloudPostsModel> dataList = [];
    dataList = data.map((item) {
      return CloudPostsModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();
    return PostList(posts: dataList);
  }
}
