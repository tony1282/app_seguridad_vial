import 'package:flutter/material.dart';
import '../models/watch_data.dart';

class WatchProvider extends ChangeNotifier {
  WatchData _data = const WatchData();

  WatchData get data => _data;

  bool get isConnected => _data.isConnected;
  double get speed => _data.speed;
  int get battery => _data.battery;
  bool get isGpsActive => _data.isGpsActive;

  void updateData(WatchData newData) {
    _data = newData;
    notifyListeners();
  }

  void toggleGps() {
    _data = _data.copyWith(isGpsActive: !_data.isGpsActive);
    notifyListeners();
  }

  void setConnected(bool value) {
    _data = _data.copyWith(isConnected: value);
    notifyListeners();
  }
}
