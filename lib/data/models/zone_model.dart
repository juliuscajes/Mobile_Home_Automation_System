import 'device_model.dart';

class ZoneModel {
  final String zoneId;
  final String zoneName;
  final List<DeviceModel> devices;

  ZoneModel({
    required this.zoneId,
    required this.zoneName,
    required this.devices,
  });

  int get activeCount => devices.where((d) => d.isOn).length;
}
