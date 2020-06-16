import 'package:flutter/material.dart';
import 'components/location_map.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('位置情報を取得'),
      ),
      body: LocationMap(),
    ),
  ));
}