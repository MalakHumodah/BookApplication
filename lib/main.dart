import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/router/constant_router.dart';
import 'package:myapp/router/router.dart';
import 'package:myapp/state_management/Provider/Models/buySell_post_provider.dart';
import 'package:myapp/state_management/Provider/Models/review_post_provider.dart';
import 'package:myapp/state_management/SharedPref/shared_pref.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  ///activate async and await
  //ensure prefs instance initialized then run the app
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();

  runApp(RealTimeDataBaseApp());
}


class RealTimeDataBaseApp extends StatelessWidget {
  const RealTimeDataBaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>BuySellPostProvider()),
        ChangeNotifierProvider(create: (context)=>ReviewPostProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:splashPage,
        onGenerateRoute: RouterClass.generate,
        //home: GetPosts(),
      ),
    );
  }
}

/*runApp(
  MultiProvider(providers: [
    ChangeNotifierProvider(create:(context)=> SimpleProvider())
  ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Application",
      initialRoute:splashPage,
      onGenerateRoute: RouterClass.generate,
    )
  )
);*/
//GridViewCountWidget
//GridViewBuilderWidget
//GridViewExtentWidget
