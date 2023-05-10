import 'package:chataapproutecourse/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/Message.dart';

class SenderMessage extends StatelessWidget {
  Message message;
  SenderMessage(this.message);

  @override
  Widget build(BuildContext context) {
    int ts = message.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);

    var date = DateFormat('hh:mm a').format(dt);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
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
