import 'package:flutter/material.dart';
import 'components/ar_component.dart';
import 'components/yonaki_proto.dart';

void main() => runApp(MaterialApp(
  initialRoute: YonakiProto.id,
  routes: {
    ARComponent.id: (context) => ARComponent(),
    YonakiProto.id: (context) => YonakiProto(),
  },
));