import 'package:chataapproutecourse/Provider/UserProv.dart';
import 'package:chataapproutecourse/models/Message.dart';
import 'package:chataapproutecourse/shared/components/MessageWidget/recivedmessage.dart';
import 'package:chataapproutecourse/shared/components/MessageWidget/sendermessage.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget(this.message);
  @override
  Widget build(BuildContext context) {
    return UserProvider.user?.id == message.senderId
        ? SenderMessage(message)
        : RecivedMessage(message);
  }
}
