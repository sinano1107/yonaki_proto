import 'package:flutter/material.dart';
import 'components/ar_component.dart';
import 'components/yonaki_proto.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: Text('位置情報を取得'),
    ),
    body: YonakiProto(),
  ),
  routes: {
    ARComponent.id: (context) => ARComponent(),
  },
));