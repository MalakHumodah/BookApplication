import 'dart:collection';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:myapp/FireBase/authentication/auth_services/authen_service.dart';

import '../../FireBase/authentication/auth_services/connectivity_service.dart';
import '../../router/constant_router.dart';
import 'package:myapp/state_management/SharedPref/shared_pref.dart';

import '../../state_management/SharedPref/service/user_service.dart';
import '../../widgets/internet_connection_dialog.dart';
import '../../widgets/loader.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Color c1 = Color(0xCDf0eafb); // white -> background of container
  Color c2 = Color(0xCDa56cf0); // purple (dark) -> color of font
  Color c3 = Color(0xCD6d598e); // purple (More dark) -> color of font
  final AuthService authService = AuthService();
  final email = TextEditingController();
  final password = TextEditingController();
  final userName = TextEditingController();
  final phoneNum = TextEditingController();
  final _loaderKey = GlobalKey<State>();


  HashMap userMap = HashMap();
  final UserService _service = UserService();
  bool isVisible = true;

  final formKey = GlobalKey<FormState>(); // Form key

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: c3,
          title: Text('SignUpPage'),
        ),
        body: Stack(
          children: [
            ///Image as background
            Center(
                child:
                    Image.asset('assets/Imgs/signUpBG.jpg', fit: BoxFit.fill)),

            //The container that contain Form
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: c1,
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Text (SignUp)
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 40,
                                color: c2,
                                fontWeight: FontWeight.w800),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 40,
                          ),

                          ///User Name Field
                          Text(
                            'User Name',
                            style: TextStyle(
                                fontSize: 15,
                                color: c3,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            controller: userName,
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'please enter your Name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Your Name',
                              hintStyle: TextStyle(color: Colors.black38),
                              suffixIcon: Icon(
                                Icons.account_circle,
                                color: c3,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: c3, width: 2.5)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: c2, width: 2.5)),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          ///Email Field
                          Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 15,
                                color: c3,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            controller: email,
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'please enter your Email';
                              }
                              if (!emailValidate(input)) {
                                return 'In Correct Email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'example@example.com',
                              hintStyle: TextStyle(color: Colors.black38),
                              suffixIcon: Icon(
                                Icons.mail,
                                color: c3,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: c3, width: 2.5)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: c2, width: 2.5)),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          ///Password Field
                          Text(
                            'Password',
                            style: TextStyle(
                                fontSize: 15,
                                color: c3,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            controller: password,
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'please enter your password';
                              }
                              if (input.length < 6) {
                                return 'the password must be more than 6 numbers';
                              }
                              return null;
                            },
                            obscureText: isVisible,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.black38),
                              suffixIcon: isVisible
                                  ? InkWell(
                                      child: Icon(
                                        Icons.visibility_off,
                                        color: c3,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                    )
                                  : InkWell(
                                      child: Icon(
                                        Icons.visibility,
                                        color: c3,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                    ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: c3, width: 2.5)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: c2, width: 2.5)),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          ///Phone Number Field
                          Text(
                            'Phone Number',
                            style: TextStyle(
                                fontSize: 15,
                                color: c3,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            controller: phoneNum,
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'please enter your Phone Number';
                              }
                              if (input.length < 10 || input.length > 10) {
                                return 'Incorrect Phone Number';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: '0798745632',
                              hintStyle: TextStyle(color: Colors.black38),
                              suffixIcon: Icon(
                                Icons.phone,
                                color: c3,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: c3, width: 2.5)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: c2, width: 2.5)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          ///Go to sign up page
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .popAndPushNamed(signInPage);
                              },
                              child: Text(
                                'You have an account?',
                                style: TextStyle(color: c3),
                              )),
                          SizedBox(
                            height: 30,
                          ),

                          ///Button
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: c3),
                                onPressed: () async {
                                  validateAndSubmit(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 100.0, vertical: 15),
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(fontSize: 19),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void validateAndSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (await ConnectivityService.checkInternetConnectivity()) {
        Loader.showLoadingScreen(context, _loaderKey);
        //1:
        var userData = HashMap();
        userData['email'] = email.text.trim();
        userData['password'] = password.text.trim();
        userData['name'] = userName.text.trim();
        userData['phoneNum'] = phoneNum.text.trim();


        ///for prefs file
        bool result1 =
        await _service.signUp(userData);
        if (result1) {
          Prefs.setString("userEmail", email.text);
          Navigator.of(context)
              .popAndPushNamed(signInPage);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(
              content:
              Text('Email not found')));
        }


        //2:
        var result =await authService.signUp(userData);

        //3:
        Navigator.of(_loaderKey.currentContext ?? context, rootNavigator: true)
            .pop();

        if (result == "Weak Password") {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Password should be al least 6 letters")));
        } else if (result == "The account is already exists Try Sign in") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Email is used")));
        } else {
          //Navigator to home page
          Navigator.of(context).pushReplacementNamed(signInPage);

        }
      } else {
        internetConnectionDialog(context);
      }
    }
  }
}

bool emailValidate(String email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}
