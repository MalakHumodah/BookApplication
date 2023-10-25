import 'package:flutter/material.dart';
import 'package:myapp/state_management/SharedPref/user_model.dart';

import '../../router/constant_router.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Color c2 = Color(0xCD6159e6); // purple
  Color c1 = Color(0xCD34325e); // dark blue
  Color c3 = Color(0xCDffffff); // white
  Color c4 = Color(0xCDf0f0ff); // white purple

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/Imgs/pic2.png',
              height: height / 3,
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),

                ///welcome text
                Text('Welcome',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 40, color: c1),
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 20,
                ),

                ///simple summery txt
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                      'enjoy reading your favorite books right now for free ',
                      style: TextStyle(
                          fontWeight: FontWeight.w100, fontSize: 20, color: c2),
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  height: 40,
                ),

                ///Sign IN Button
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(200, 60),
                        backgroundColor: c2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.of(context).pushNamed(signInPage);
                    },
                    child: Text(
                      'SignIn',
                      style: TextStyle(fontSize: 25, color: c3),
                    )),
                SizedBox(
                  height: 20,
                ),

                ///Sign UP Button
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(200, 60),
                        backgroundColor: c1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.of(context).pushNamed(signUpPage);
                    },
                    child: Text(
                      'SignUp',
                      style: TextStyle(fontSize: 25, color: c3),
                    )),
                SizedBox(
                  height: 40,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
