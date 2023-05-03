import 'package:chataapproutecourse/Provider/UserProv.dart';
import 'package:chataapproutecourse/models/user_model.dart';
import 'package:chataapproutecourse/screens/Login/LoginScreen.dart';
import 'package:flutter/material.dart';

import '../../shared/components/Background/Background.dart';
import '../Addroom/add_room.dart';
import 'NavDrawer.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const BackgroundContainer(),
      Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddRoomScreen()));
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.transparent,
        drawer: NavDrawer(),
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Chat App',
            style: TextStyle(fontSize: 25),
          )),
          actions: [
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
