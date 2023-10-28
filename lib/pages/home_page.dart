
import 'package:flutter/material.dart';
import 'package:myapp/widgets/home_page_widget.dart';
import 'package:myapp/state_management/SharedPref/shared_pref.dart';
import '../router/constant_router.dart';
import '../state_management/SharedPref/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.model}) : super(key: key);
  final UserModel model;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  String str = "Home Page";
  bool favoriteBool = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      drawer: MyDrawer(model: widget.model,),
      body: Center(child: HomePageWidget()),
    );
  }
}

///for Drawer
class tileWidget extends StatelessWidget {
  const tileWidget(
      {Key? key, required this.icon, required this.txt, required this.onTap})
      : super(key: key);
  final VoidCallback onTap;
  final String txt;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(txt),
    );
  }
}



class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key, required this.model}) : super(key: key);
  final UserModel model;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        //have Container and ListTile -> the Container has column and the column has (circle avatar and 2 txt) wrapped with padding
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Circle Avatar
          Container(
            height: 200,
            width: double.maxFinite,
            color: Colors.blue.shade400,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),

                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/imgs/ffa09aec412db3f54deadf1b3781de2a.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //Text 1
                  Text(
                    'Hello ${widget.model.name}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 3,
                  ),

                  //Text 2
                  Text(
                    '${widget.model.email}',
                    style: TextStyle(color: Colors.white54),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          //ListTile
          tileWidget(
            icon: Icons.home,
            txt: " Home ",
            onTap: () {
              Navigator.of(context).popAndPushNamed(homePage);
            },
          ),
          Divider(
            thickness: 1.5,
          ),
          tileWidget(
            icon: Icons.account_circle,
            txt: " Your Profile ",
            onTap: () {
              //ProfilePage
              Navigator.of(context).popAndPushNamed(profilePage);

            },
          ),
          Divider(
            thickness: 1.5,
          ),
          tileWidget(
            icon: Icons.align_vertical_top_sharp,
            txt: " Your Posts ",
            onTap: () {
              //Navigator.of(context).popAndPushNamed(homePage);
            },
          ),
          Divider(
            thickness: 1.5,
          ),
          tileWidget(
            icon: Icons.favorite,
            txt: " WishList ",
            onTap: () {
              //Navigator.of(context).popAndPushNamed(bestBooksScreen);
            },
          ),
          Divider(
            thickness: 1.5,
          ),
          tileWidget(
            icon: Icons.logout,
            txt: " Logout ",
            onTap: () {
              Prefs.setBool('signInState', false);
              Navigator.of(context).popAndPushNamed(welcomePage);
            },
          ),
          Divider(
            thickness: 1.5,
          ),
        ],
      ),
    );
  }
}

