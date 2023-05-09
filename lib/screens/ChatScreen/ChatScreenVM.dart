import 'package:chataapproutecourse/DataBase/DataBase.dart';
import 'package:chataapproutecourse/Provider/UserProv.dart';
import 'package:chataapproutecourse/models/Message.dart';
import 'package:flutter/material.dart';

import '../../base.dart';
import '../../models/category.dart';

class ChatScreenVm extends ChangeNotifier {
  late Connector connect;
  late Rooms rooms;
  void sendMessage(String content) {
    print(UserProvider.user?.id);
    addMessageToData(Message(
      content: content,
      dateTime: DateTime.now().microsecondsSinceEpoch,
      roomId: rooms.id,
      senderId: UserProvider.user!.id,
      senderName: UserProvider.user!.name,
    ));
  }
}
