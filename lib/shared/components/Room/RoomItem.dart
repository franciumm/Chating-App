import 'package:chataapproutecourse/Provider/UserProv.dart';
import 'package:chataapproutecourse/screens/ChatScreen/ChatScreen.dart';
import 'package:flutter/material.dart';

import '../../../DataBase/DataBase.dart';
import '../../../models/category.dart';

class RoomItem extends StatelessWidget {
  Rooms Room;

  RoomItem(this.Room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        addjoineduserToData(UserProvider.user?.id ?? '', Room.id);
        Navigator.pushNamed(arguments: Room, context, 'ChatScreen');
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/${Room.cat}.png',
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.1,
                filterQuality: FilterQuality.high,
              ),
            ),
            Text(Room.name),
          ]),
        ),
      ),
    );
  }
}
