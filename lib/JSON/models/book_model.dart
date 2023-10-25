class BookModel{
  String? title;
  String? author;
  String? type;
  String? img;
  String? description;

  BookModel({this.title, this.author, this.type, this.img, this.description});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
        title: json['title'],
        author: json['author'],
        type: json['type'],
        img: json['img'],
        description: json['description']);
  }

  BookModel.fromJson2(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    type = json['type'];
    img = json['img'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['title'] = title;
    data['author'] = author;
    data['type'] = type;
    data['img'] = img;
    data['description'] = description;
    return data;
  }
}

class BooksList {
  List<BookModel> books;

  BooksList({required this.books});

  factory BooksList.fromJson(List<dynamic> photos) {
    List<BookModel> data = [];
    data = photos.map((item) => BookModel.fromJson(item)).toList();
    return BooksList(books: data);
  }
}
