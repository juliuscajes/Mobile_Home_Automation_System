import 'package:flutter/material.dart';
import '../data/models/device_model.dart';
import '../data/mock/mock_data.dart';

class DeviceProvider extends ChangeNotifier {
  final List<DeviceModel> _devices = List.from(MockData.devices);

  List<DeviceModel> get devices => _devices;
  List<DeviceModel> get activeDevices => _devices.where((d) => d.isOn).toList();

  DeviceModel? getById(String id) {
    try {
      return _devices.firstWhere((d) => d.deviceId == id);
    } catch (_) {
      return null;
    }
  }

  void toggleDevice(String deviceId) {
    final i = _devices.indexWhere((d) => d.deviceId == deviceId);
    if (i != -1) {
      _devices[i].isOn = !_devices[i].isOn;
      _devices[i].controlSource = 'App';
      notifyListeners();
    }
  }

  void toggleZone(String zoneId, bool turnOn) {
    for (var d in _devices) {
      if (d.zoneId == zoneId) d.isOn = turnOn;
    }
    notifyListeners();
  }
}
