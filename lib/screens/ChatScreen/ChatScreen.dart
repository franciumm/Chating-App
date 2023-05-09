import 'package:chataapproutecourse/screens/ChatScreen/ChatScreenVM.dart';
import 'package:chataapproutecourse/shared/components/Background/Background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base.dart';
import '../../models/category.dart';
import '../../models/utls/constants.dart';

class ChatScreen extends StatelessWidget implements Connector {
  var Chatvm;

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)?.settings.arguments as Rooms;
    return ChangeNotifierProvider(
      create: (context) => ChatScreenVm(),
      builder: (context, child) {
        Chatvm = Provider.of<ChatScreenVm>(context);
        Chatvm.connect = this;
        Chatvm.rooms = room;
        return Stack(
          children: [
            const BackgroundContainer(),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(
                  room.name,
                  style: TextStyle(fontSize: 25),
                ),
              ),
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 48),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.65,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 14.0, right: 7, left: 7),
                      child: Container(
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: MessageController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(12))),
                                    hintText: 'Type a message'),
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            InkWell(
                              onTap: () {
                                if (MessageController.text.trim() != '') {
                                  Chatvm.sendMessage(MessageController.text);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    )),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Send',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void hideLoading() {}

  @override
  void navtohome() {}

  @override
  void showLoading() {}

  @override
  void showMessage(String text) {}
}
