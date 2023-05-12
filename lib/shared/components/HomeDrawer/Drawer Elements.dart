import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Provider/UserProv.dart';
import '../../../models/user_model.dart';
import '../../../screens/Addroom/add_room.dart';
import '../../../screens/Login/LoginScreen.dart';
import '../Background/Background.dart';

Widget Drawerhead(BuildContext context) => Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.top),
      child: Stack(
        children: [
          Container(height: 100, child: const BackgroundContainer()),
          Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1),
                      shape: BoxShape.circle,
                    ),
                    child: UserProvider.user?.photo != ''
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                                UserProvider.user!.photo.toString()),
                          )
                        : const Icon(
                            Icons.account_circle_outlined,
                            size: 80,
                            color: Colors.black87,
                          ),
                  ),
                ),
              ),
              Text(
                UserProvider.user?.name ?? '',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );

Widget DrawerBody(BuildContext context) => Column(
      children: [
        Wrap(children: [
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddRoomScreen()));
            },
            title: const Text(
              'Create Room',
              style: TextStyle(color: Colors.black),
            ),
            leading: Icon(
              Icons.add,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: Divider(),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              UserProvider.user = UserModel(id: '', name: '', Email: '');

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => LoginScreen()),
                  (route) => false);
            },
            title: const Text(
              'Log out',
              style: TextStyle(color: Colors.black),
            ),
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ])
      ],
    );
