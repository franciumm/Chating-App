import 'dart:io';
import 'package:flutter/cupertino.dart';

import '../category.dart';

bool userindatabase = true;
String weakpassword = 'weak-password';
String EmailInUse = 'email-already-in-use';
File? image;
String email = '';
String Pass = '';
String Name = '';
var RoomNameController = TextEditingController();
String RoomName = '';
var MessageController = TextEditingController();

var RoomDesController = TextEditingController();
String RoomDes = '';
List<String> Catlist = <String>['Movies', 'Music', 'Sports'];
String dropdownValue = Catlist.first;
var PassController = TextEditingController();
var EmailController = TextEditingController();
var NameController = TextEditingController();
const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
    r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
    r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
    r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
    r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
    r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
    r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
