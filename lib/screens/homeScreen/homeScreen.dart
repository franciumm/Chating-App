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
