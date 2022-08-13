import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bottomnavigationpages/feed.dart';
import 'package:flutter_application_1/bottomnavigationpages/homepage.dart';
import 'package:flutter_application_1/bottomnavigationpages/setting.dart';
import 'package:flutter_application_1/getdata/getdata.dart';
import 'package:flutter_application_1/pages/loginpage.dart';
import 'package:flutter_application_1/theme%20privider/changethemebutton.dart';
import 'package:google_sign_in/google_sign_in.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int currentindex = 0;
  final screen = const [
    homepage(),
    feed(),
    setting(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          const DrawerHeader(
            
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              accountName: Text(
                "hamza",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              accountEmail: Text(
                "hamza@gmail.com",
                style: TextStyle(color: Colors.black),
              ),
              currentAccountPictureSize: Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "H",
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ),
              ),
            ),
          ),
          const ListTile(
            title: Text("Setting"),
            leading: Icon(Icons.settings),
          ),
          const ListTile(
            title: Text("Wifi"),
            leading: Icon(Icons.wifi),
          ),
          const ListTile(
            title: Text("Airplane"),
            leading: Icon(Icons.airplanemode_active),
          ),
          ListTile(
            title: const Text("Theme"),
            leading: const Icon(Icons.dark_mode),
            trailing: changethemebutton(),
          ),
          const ListTile(
            title: Text("Chats"),
            leading: Icon(Icons.chat),
          ),
          const ListTile(
              title: Text("Faverites"), leading: Icon(Icons.favorite)),
          ListTile(
              title: const Text("Logs out"),
              leading: const Icon(Icons.logout),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const loginpage()));
              }),
          ListTile(
              title: const Text("google log out"),
              leading: const Icon(Icons.logout),
              onTap: () async {
                await GoogleSignIn().disconnect();
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const loginpage()));
              }),
        ],
      )),
      body: screen[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.green,
        currentIndex: currentindex,
        onTap: (index) => setState(() {
          currentindex = index;
        }),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
