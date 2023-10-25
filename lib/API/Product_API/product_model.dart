class ProductModel {
  int? id;
  String? name;
  String? description;
  String? category;
  int? price;
  String? image;

  ProductModel(
      {this.id,
        this.name,
        this.description,
        this.category,
        this.price,
        this.image});

  factory ProductModel.fromJson(Map<String,dynamic> json){
    return ProductModel(
        id : json['id'],
        name : json['name'],
        description : json['description'],
        category : json['category'],
        price : json['price'],
        image : json['image']
    );
  }

  ProductModel.fromJson2(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    category = json['category'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['category'] = category;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}

class ProductsList {
  List<ProductModel> products;

  ProductsList({required this.products});

  factory ProductsList.fromJson(List<dynamic> data) {
    List<ProductModel> list = [];

    list = data.map((item) => ProductModel.fromJson(item)).toList();

    return ProductsList(products:list );
  }
}