class DeviceModel {
  final String deviceId;
  final String deviceName;
  final String zoneId;
  final int relayChannel;
  final String type; // Light, Fan, Socket
  bool isOn;
  String controlSource; // App, Voice, Push Button
  double powerUsage; // kWh

  DeviceModel({
    required this.deviceId,
    required this.deviceName,
    required this.zoneId,
    required this.relayChannel,
    required this.type,
    this.isOn = false,
    this.controlSource = 'App',
    this.powerUsage = 0.0,
  });
}
