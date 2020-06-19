import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class ARComponent extends StatefulWidget {
  static const String id = 'AR';

  @override
  _ARComponentState createState() => _ARComponentState();
}

class _ARComponentState extends State<ARComponent> {
  UnityWidgetController _unityWidgetController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: UnityWidget(onUnityViewCreated: onUnityCreated),
          flex: 10,
        ),
        Expanded(
          child: Card(
            child: Center(
              child: MaterialButton(
                child: Text('Unityにメッセージを送信'),
                onPressed: sendMessageToUnity,
              ),
            ),
          ),
          flex: 1,
        ),
      ],
    );
  }

  void sendMessageToUnity() {
    _unityWidgetController.postMessage(
        'GameDirector', 'EditText', 'Flutterからのメッセージ');
  }

  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }
}
