class SearchModel {
  List<Results>? results;

  SearchModel({this.results});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }
}

class Results {
  String? iSBN;
  String? author;
  String? description;
  String? imgLink;
  String? pdfLink;
  String? publisher;
  String? title;
  String? year;

  Results(
      {this.iSBN,
      this.author,
      this.description,
      this.imgLink,
      this.pdfLink,
      this.publisher,
      this.title,
      this.year});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
        iSBN: json['ISBN'],
        author: json['author'],
        description: json['description'],
        imgLink: json['img_link'],
        pdfLink: json['pdf_link'],
        publisher: json['publisher'],
        title: json['title'],
        year: json['year']);
  }

  Results.fromJson2(Map<String, dynamic> json) {
    iSBN = json['ISBN'];
    author = json['author'];
    description = json['description'];
    imgLink = json['img_link'];
    pdfLink = json['pdf_link'];
    publisher = json['publisher'];
    title = json['title'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ISBN'] = iSBN;
    data['author'] = author;
    data['description'] = description;
    data['img_link'] = imgLink;
    data['pdf_link'] = pdfLink;
    data['publisher'] = publisher;
    data['title'] = title;
    data['year'] = year;
    return data;
  }
}
