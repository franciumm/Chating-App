import 'package:chataapproutecourse/DataBase/DataBase.dart';
import 'package:chataapproutecourse/Provider/UserProv.dart';
import 'package:chataapproutecourse/models/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../base.dart';
import '../../models/category.dart';
import '../../models/utls/constants.dart';

class ChatScreenVm extends ChangeNotifier {
  late Connector connect;
  late Rooms rooms;
  void sendMessage(String content) {
    print(UserProvider.user?.id);
    addMessageToData(Message(
      content: content,
      dateTime: DateTime.now().microsecondsSinceEpoch,
      roomId: rooms.id,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      senderName: UserProvider.user!.name,
    )).then((value) {
      MessageController.clear();
    });
  }

  Stream<QuerySnapshot<Message>> getMessage() {
    return readMessage(rooms.id);
  }
}
