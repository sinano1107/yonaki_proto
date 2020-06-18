import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:yonakiproto/services/latlong_service.dart';
import 'package:yonakiproto/services/parameter.dart';

class LocationMap extends StatefulWidget {
  final Function showAR;

  LocationMap({
    @required this.showAR,
  });

  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  Completer<GoogleMapController> _controller = Completer();
  Location _locationService = Location();

  // 現在位置
  LocationData _location;

  // 現在位置の監視状況
  StreamSubscription _locationChangedListen;

  // オトシモノシステム用の位置情報保存変数
  LocationData _beforeLocation;

  // テスト用変数群
  int _testWaitTime = 0;
  double _testDistance = 0;
  String message = 'message';

  @override
  void initState() {
    super.initState();

    // 現在位置の取得
    _getLocation();

    // 現在位置の変化を監視
    _locationChangedListen =
        _locationService.onLocationChanged.listen((LocationData result) async {
      setState(() {
        _location = result;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    // 監視を終了
    _locationChangedListen?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _makeGoogleMap(),
          Column(
            children: <Widget>[
              Text(
                '$_testWaitTime秒後に判定',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                '$_testDistance m移動しました',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                message,
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _makeGoogleMap() {
    if (_location == null) {
      // 現在位置が取れるまではローディング中
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      // Google Map ウィジェットを返す
      return GoogleMap(
        // 初期表示される位置情報を現在位置から設定
        initialCameraPosition: CameraPosition(
          target: LatLng(_location.latitude, _location.longitude),
          zoom: 18.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

        // 現在位置にアイコン（青い円形のやつ）を置く
        myLocationEnabled: true,
      );
    }
  }

  void _getLocation() async {
    _location = await _locationService.getLocation();
    await Future.delayed(Duration(seconds: Parameter.kLocationInitTime));
    print('${Parameter.kLocationInitTime}秒たったのでbeforeLocationに代入');
    _beforeLocation = _location;
    _loopCheckLocation();
  }

  void _loopCheckLocation() async {
    while (true) {
      // 待ち時間
      final _waitTime = Random().nextInt(Parameter.kLocationCheckRandom) +
          Parameter.kLocationCheckFoundation;

      setState(() {
        _testWaitTime = _waitTime;
      });

      await Future.delayed(Duration(seconds: _waitTime));
      print('$_waitTime秒待ったので直線距離で測定');
      final _distance = LatlongService()
          .getDistance(data1: _beforeLocation, data2: _location);

      setState(() {
        _testDistance = _distance;
        if (_distance >= Parameter.kOtosimonoDistance) {
          message = 'オトシモノがありました！';
          widget.showAR(context);
        } else {
          message = 'オトシモノはありません';
        }
      });

      print('$_distance m移動しました');
      _beforeLocation = _location;
    }
  }
}
