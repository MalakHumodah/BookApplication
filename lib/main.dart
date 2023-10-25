import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/realtime_posts_pages/adding_post_page.dart';
import 'package:myapp/pages/realtime_posts_pages/get_posts_page.dart';
import 'package:myapp/router/constant_router.dart';
import 'package:myapp/router/router.dart';
import 'package:myapp/state_management/Provider/Models/post_provider.dart';
import 'package:myapp/state_management/SharedPref/service/shared_pref.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Application",
      home: AddingPostPage(),
      // home: Select(),
    );
  }
}

class RealTimeDataBaseApp extends StatelessWidget {
  const RealTimeDataBaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostProvider()),
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
