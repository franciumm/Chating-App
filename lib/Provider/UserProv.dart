import 'package:chataapproutecourse/DataBase/DataBase.dart';
import 'package:chataapproutecourse/models/utls/constants.dart';
import 'package:chataapproutecourse/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserProvider {
  static User? Firebaseuser;
  static UserModel? user;
}
