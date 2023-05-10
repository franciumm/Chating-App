import 'package:chataapproutecourse/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/Message.dart';

class RecivedMessage extends StatelessWidget {
  Message message;
  RecivedMessage(this.message);
  @override
  Widget build(BuildContext context) {
    int ts = message.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);

    var date = DateFormat('hh:mm a').format(dt);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  )),
              child: Text(
                message.content,
                style: TextStyle(color: Colors.white),
              )),
          Text(
            date,
            style: TextStyle(fontSize: 9, color: Colors.black38),
          )
        ],
      ),
    );
  }
}
