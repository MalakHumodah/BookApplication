import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/state_management/SharedPref/service/shared_pref.dart';

import '../../router/constant_router.dart';
import '../../state_management/SharedPref/service/user_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  Color c1 = Color(0xCD243762); // Blue(dark)
  Color c3 = Color(0xCDedabb8); // pink(dark)
  Color c2 = Color(0xCDaf9cda); // purple -> background
  Color c4 = Color(0xCDe8f0ff); // Blue(light)
  Color c5 = Color(0xCDf9bfc7); // pink(light)
  bool isVisible=true;
  final formKey=GlobalKey<FormState>();

  UserService _service = UserService();

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: c2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: c2,
                  height: height/2,
                ),
                ///Login Icon
                Center(child: LottieBuilder.asset('assets/78126-secure-login.json',height:height/2.5,fit: BoxFit.fitWidth,)),
                ///Form Container
                Padding(
                  padding:  EdgeInsets.only(top: height/3,left:15,right:15),
                  child: Container(
                    height: height*3/4,
                    color: c4,
                    //color: Colors.white,
                    child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20,),
                              Text('Sign In',style: TextStyle(fontSize: 25,color: c1),),
                              SizedBox(height: 40,),

                              ///Email Field
                              Text('Email',style: TextStyle(fontSize: 15,color: c1),),
                              TextFormField(
                                controller: email,
                                validator: (input)
                                {
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

                                  suffixIcon: Icon(Icons.mail,color: c1,),

                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: c2,width: 2.5)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: c1,width: 2.5)),

                                ),

                              ),
                              SizedBox(height: 30,),

                              ///Password Field
                              Text('Password',style: TextStyle(fontSize: 15,color: c1),),
                              TextFormField(
                                controller: password,
                                validator: (input)
                                {
                                  if (input!.isEmpty) {
                                    return 'please enter your password';
                                  }
                                  return null;
                                },

                                obscureText: isVisible,

                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.black38),

                                  suffixIcon: isVisible? InkWell(child: Icon(Icons.visibility_off,color: c1,),onTap: (){
                                    setState(() {
                                      isVisible=!isVisible;
                                    });
                                  },):InkWell(child: Icon(Icons.visibility,color: c1,),onTap: (){
                                    setState(() {
                                      isVisible=!isVisible;
                                    });
                                  },),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: c2,width: 2.5)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: c1,width: 2.5)),

                                ),
                              ),

                              ///ForgetYourPassword
                              Padding(
                                padding: EdgeInsets.only(left:150,top: 6),
                                child: TextButton(
                                    onPressed: (){},
                                    child: Text('Forget Your Password',
                                      style:TextStyle(color: c1),
                                    )
                                ),
                              ),
                              SizedBox(height: 20,),

                              ///Button
                              Center(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor:c2 ),
                                    onPressed: () async {
                                      if(formKey.currentState!.validate())
                                      {
                                        var model = _service.signIn(email.text, password.text);

                                        var id =model.id;
                                        if (id=='-2') //key not found
                                          {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email not found')));
                                          }
                                        else
                                          {
                                            if (id =='-1') //Password InCorrect
                                            {
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong Password')));
                                            }
                                            else //Everything is correct
                                              {
                                               await Prefs.setBool('signInState', true);
                                                await Prefs.setString('UserEmail', model.email!); //so we have in prefs file : loginState,email and data(user Info) so i can get what i want from this info
                                                //arguments : get data that i need
                                                Navigator.of(context).popAndPushNamed(homePage,arguments:model);
                                              }
                                          }
                                      }
                                      else {
                                        log('Error');
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 100.0,vertical: 15),
                                      child: Text('LogIn',style: TextStyle(fontSize:19 ),),
                                    )
                                ),
                              ),
                              SizedBox(height: 10,),

                              ///Sign in with Facebook or Google
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(onPressed: (){}, icon:Image.asset('assets/Icons/icons8-facebook-48.png'),iconSize: 40,),
                                  SizedBox(width: 15,),
                                  IconButton(onPressed: (){}, icon:Image.asset('assets/Icons/icons8-google-50.png',),iconSize: 60),
                                ],
                              ),
                              SizedBox(height: 2,),

                              ///Go to sign up page
                              TextButton(
                                  onPressed: (){
                                    Navigator.of(context).popAndPushNamed(signUpPage);
                                  },
                                  child: Text('You don\'t have an account?',
                                    style:TextStyle(color: c1),
                                  )
                              ),


                            ],
                          ),
                        )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

bool emailValidate(String email){
  return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(email);
}

