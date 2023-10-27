//encapsulation for data from user

import 'dart:collection';
import 'dart:convert';

import 'package:myapp/state_management/SharedPref/shared_pref.dart';
import 'package:uuid/uuid.dart';

import '../user_model.dart';

//convert data from screens to obj then perform a specific process then send it to sharedPref files
//the process is decode and encode
//encode -> obj to string (So that I can use it in sharedPref file)
//decode -> string to obj

//mediator between all files
class UserService {
  //create -- log

  Future<bool>  signUp(HashMap data) async{
    var uuid = Uuid();
    // data -- > object , model
    //get the data from the map then
    //store the data in the obj then to string to save it in the prefFile

    var userModel = UserModel(
        name: data['name'],
        phoneNum: data['phoneNum'],
        email: data['email'],
        password: data['password'],
        id: uuid.v4());
    //model -> string
//convert the obj to string so I can save it in the prefFiles
    var encodeModel = json.encode(userModel);
//save the data in the prefFiles
    var result = Prefs.setString(userModel.email!, encodeModel);
    return result;
  }

  //sign Up -> save the info of the user
  //sign in -> get the info from the user and compare it with the info in the prefFile
  UserModel signIn(String email,String password){
    var data = Prefs.getString(email);
    if(data !=null) //if the fun getString return null -> email not found
    {
      //if the email is correct so i need all info about this email (like the password to compare it with the entered password)
      //decode because the data comes as string from user
      var decodeData= json.decode(data);
      var userModel = UserModel.fromJson(decodeData);

      //check if the password is correct for the email that entered or not
      if(userModel.password == password)
      {
        return userModel;
      }
      else
      {
        return  UserModel(
            id: '-1'
        );
      }
    }
    return UserModel(
        id: '-2'
    );



  }
}