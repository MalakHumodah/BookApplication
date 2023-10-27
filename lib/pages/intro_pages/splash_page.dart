import 'dart:convert';
import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/intro_pages/startPage.dart';
import 'package:myapp/pages/intro_pages/welcome_page.dart';
import 'package:myapp/state_management/SharedPref/shared_pref.dart';

import '../../FireBase/real_time_dataBase/post_model.dart';
import '../../FireBase/real_time_dataBase/post_service.dart';
import '../../state_management/SharedPref/user_model.dart';
import '../home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Color c2 = Color(0xCD9cd8e2); // blue -> background of container
  Color c1 = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
      body: Column(
        children: [
          ///Animated Splash Screen
          Expanded(
            flex: 3,
            child: AnimatedSplashScreen.withScreenFunction(
              backgroundColor: c1,
              splash: 'assets/Imgs/img.png',splashIconSize: 500,

              //the idea here how to get the model from shared files and use it in this widget
              screenFunction: () async {
                await setPostData();
                //check logIn state
                //log -> t home , f -> wel
                var state = userLogInState(); //t , f
                if (state) {
                  //In order to get the data of the user ,, i need the key(the key is the ID)
                  // model.id = 1, 2 , other
                  UserModel model = getUserModel();
                  if (model.id == '1') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "You don't have an account"))); //You don't have an account
                    return StartPage();
                  }
                  //I have a problem (i don't know what is the problem so i will go to the welcome page)
                  else if (model.id == '2') {
                    SnackBar(content: Text("Wrong data"));
                    return StartPage();
                  } else {
                    return HomePage(
                      model: model,
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("You don't have an account")));
                  return WelcomePage();
                }
              },
              splashTransition: SplashTransition.fadeTransition,
            ),
          ),

          ///Circular Progress Indicator
          Expanded(
            flex: 1,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  setPostData() async {
    PostList postList;
    List<String> postsAsStrings = [];
    PostService postService = PostService();
    var jsonData;
    var encodeData;
    //get the serv data
    postList = await postService.getPost();
    //[]
    if (postList.posts.isNotEmpty) {
      for (var item in postList.posts) {
        jsonData = item.toJson();
        encodeData = json.encode(jsonData);
        postsAsStrings.add(encodeData);
      }
      Prefs.setStringList('postsData', postsAsStrings);
    }
  }
}

bool userLogInState() {
  //null same as false (in both key not found)
  return Prefs.getBool('signInState') ?? false;
}

UserModel getUserModel() {
  //return user email that entered before (stored in logIn page inside "userEmail" key)
  var email = Prefs.getString('UserEmail');

  //I have data as string and i need to convert it to json by Json.Decode process
  //to covert from string to json then from json to model so i can use it

  //get email key from shared files
  if (email == null) {
    return UserModel(id: '1');
    log('id = 1');
  } else {
    var userData = Prefs.getString(email);
    if (userData == null) {
      log('id = 2');
      return UserModel(id: '2');
    }

    //email is present so i will get user info supplement
    else {
      //data as string -> json object
      var decodeJson = json.decode(userData);

      //json object -> model
      var model = UserModel.fromJson(decodeJson);
      return model;
    }
  }
}
