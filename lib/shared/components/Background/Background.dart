import 'package:flutter/cupertino.dart';

import 'Custom Paint right.dart';
import 'Custom paint left.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: CupertinoColors.white,
        ),
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 2 / 8),
          painter: Painter2(),
        ),
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 2 / 8),
          painter: Painter1(),
        ),
      ],
    );
  }
}
