class ReviewPostsModel {
  String? id;
  String? title;
  String? author;
  String? type;
  String? summary;

  ReviewPostsModel({this.id, this.title, this.author, this.type, this.summary});

  ReviewPostsModel.fromJson(Map<String, dynamic> json) {
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
  List<ReviewPostsModel> posts;

  PostList({required this.posts});

  factory PostList.fromJson(List<dynamic> data) {
    List<ReviewPostsModel> dataList = [];
    dataList = data.map((item) {
      return ReviewPostsModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();
    return PostList(posts: dataList);
  }
}
