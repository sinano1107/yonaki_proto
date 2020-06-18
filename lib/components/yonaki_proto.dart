import 'package:flutter/material.dart';
import 'ar_component.dart';
import 'location_map.dart';

class YonakiProto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        LocationMap(showAR: showAR),
        Positioned(
          left:10,
          bottom: 10,
          child: MaterialButton(
            child: Text('強制AR'),
            onPressed: () => showAR(context),
          ),
        ),
      ],
    );
  }

  void showAR(BuildContext context) {
    Navigator.pushNamed(context, ARComponent.id);
  }
}
