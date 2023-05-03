import 'package:flutter/material.dart';

import '../../shared/components/HomeDrawer/Drawer Elements.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [Drawerhead(context), DrawerBody(context)],
        ),
      ),
    );
  }
}
