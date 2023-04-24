import 'package:chataapproutecourse/screens/Login/LoginScreen.dart';
import 'package:chataapproutecourse/screens/homeScreen/homeScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Provider/UserProv.dart';
import 'models/utls/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home:
          UserProvider.auth.currentUser != null ? homeScreen() : LoginScreen(),
    );
  }
}
