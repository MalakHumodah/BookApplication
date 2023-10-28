//convert list[data](data from user not arranged) to obj(contain the data but arranged)
//the class written from website Json to dart

class UserModel {
  //imageURL
  String? id;
  String? name;
  String? email;
  String? password;
  String? phoneNum;
  String? imageURL;

  UserModel({this.id, this.name, this.email, this.password, this.phoneNum});

  // map(json) to model(obj)
  //named constructor
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
    id : json['id'],
    name : json['name'],
    email : json['email'],
    password : json['password'],
    phoneNum : json['phoneNum']);
  }

  //model -> json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phoneNum'] = phoneNum;
    return data;
  }

  UserModel.fromJson2(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNum = json['phoneNum'];
  }

}