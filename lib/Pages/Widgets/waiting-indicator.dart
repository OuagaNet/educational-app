import 'package:educational_app/Utils/ui-color.dart';
import 'package:flutter/material.dart';

class WaitingIndicator extends StatelessWidget {
  final double height;
  const WaitingIndicator({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: height ?? 20,
          width: height ?? 20,
          child: CircularProgressIndicator(
            backgroundColor: UiColor.lighShades,
            valueColor:
                new AlwaysStoppedAnimation<Color>(UiColor.mainBrandColor),
          ),
        ),
      ],
    );
  }
}