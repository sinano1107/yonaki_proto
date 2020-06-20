import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:yonakiproto/components/yonaki_proto.dart';

class ARComponent extends StatefulWidget {
  static const String id = 'AR';

  @override
  _ARComponentState createState() => _ARComponentState();
}

class _ARComponentState extends State<ARComponent> {
  UnityWidgetController _unityWidgetController;

  @override
  void dispose() {
    // Unityを中止
    print('unityを中止');
    _unityWidgetController.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: UnityWidget(
            onUnityViewCreated: onUnityCreated,
            onUnityMessage: onUnityMessage,
          ),
          flex: 6,
        ),
        Expanded(
          child: Card(
            child: Center(
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    child: Text('Unityにメッセージを送信'),
                    onPressed: sendMessageToUnity,
                  ),
                  MaterialButton(
                    child: Text('ロケーションに戻る'),
                    onPressed: () => Navigator.pushReplacementNamed(context, YonakiProto.id),
                  ),
                ],
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

  void onUnityMessage(controller, message) {
    print('Unityからのメッセージ: ${message.toString()}');
  }

  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
    // Unityを再開
    _unityWidgetController.resume();
    // シーンを再ロード
    _unityWidgetController.postMessage('GameDirector', 'Restart', '');
  }
}
