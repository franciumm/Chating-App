import 'package:chataapproutecourse/screens/ChatScreen/ChatScreen.dart';
import 'package:chataapproutecourse/screens/Login/LoginScreen.dart';
import 'package:chataapproutecourse/screens/homeScreen/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'ChatScreen': (c) => ChatScreen(),
        'HomeScreen': (c) => homeScreen(),
        'Login': (c) => LoginScreen(),
      },
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null
          ? homeScreen()
          : LoginScreen(),
    );
  }
}
