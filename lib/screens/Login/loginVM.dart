import 'package:chataapproutecourse/DataBase/DataBase.dart';
import 'package:chataapproutecourse/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Provider/UserProv.dart';
import '../../base.dart';
import '../../models/utls/constants.dart';

class LoginViewModel extends ChangeNotifier {
  String message = '';
  late Connector connect;

  void Loginwithfirebaseauth() async {
    try {
      connect.showLoading();
      final credential = await UserProvider.auth.signInWithEmailAndPassword(
        email: email,
        password: Pass,
      );
      UserProvider.user.id = UserProvider.auth.currentUser?.uid ?? '';
      connect.hideLoading();
      await ReadUser(UserProvider.user.id).then((value) => {
            if (userindatabase == true)
              {
                connect.showMessage('Successfully Logged In'),
                connect.navtohome(),
              }
            else
              {
                connect.showMessage('Error While Trying To LogIn'),
              }
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'Password or email are Wrong';
      } else if (e.code == 'wrong-password') {
        message = 'Password or email are Wrong';
      }
    } catch (e) {
      message = 'Something went wrong ${e.toString()}';
    }
    if (message != '') {
      connect.hideLoading();
      connect.showMessage(message);
    }
  }
}
