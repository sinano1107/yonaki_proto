import 'package:flutter/material.dart';
import 'ar_component.dart';
import 'location_map.dart';

class YonakiProto extends StatelessWidget {
  static const String id = 'YonakiProto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('位置情報')),
      body: Stack(
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
      ),
    );
  }

  void showAR(BuildContext context) {
    Navigator.pushReplacementNamed(context, ARComponent.id);
  }
}
