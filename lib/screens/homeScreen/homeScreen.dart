import 'package:chataapproutecourse/Provider/UserProv.dart';
import 'package:chataapproutecourse/models/utls/user_model.dart';
import 'package:chataapproutecourse/screens/Login/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared/components/Background/Background.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const BackgroundContainer(),
      Scaffold(
        backgroundColor: Colors.transparent,
        drawer: Drawer(),
        appBar: AppBar(
          title: Center(
              child: Text(
            'Chat App',
            style: TextStyle(fontSize: 25),
          )),
          actions: [
            IconButton(
                onPressed: () {
                  UserProvider.auth.signOut();
                  UserProvider.user = UserModel(id: '', name: '', Email: '');
                  print(
                      'Logout------------------------------${UserProvider.user.id}');
                  print(UserProvider.auth);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (ctx) => LoginScreen()),
                      (route) => false);
                },
                icon: Icon(Icons.logout)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.search,
                size: 30,
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      )
    ]);
  }
}
