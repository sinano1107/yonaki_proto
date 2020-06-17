import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class ARComponent extends StatelessWidget {
  static const String id = 'AR';

  @override
  Widget build(BuildContext context) {
    return UnityWidget(
      onUnityViewCreated: (controller) => {},
    );
  }
}
