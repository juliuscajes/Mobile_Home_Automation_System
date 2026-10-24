import '../models/device_model.dart';
import '../models/zone_model.dart';
import '../models/alert_model.dart';
import '../models/user_model.dart';
import '../models/schedule_model.dart';

class MockData {
  // ============ DEVICES ============
  static List<DeviceModel> devices = [
    DeviceModel(
        deviceId: 'DEV001',
        deviceName: 'Living Room Light',
        zoneId: 'Z001',
        relayChannel: 1,
        type: 'Light',
        isOn: true,
        powerUsage: 0.80),
    DeviceModel(
        deviceId: 'DEV002',
        deviceName: 'Bedroom Fan',
        zoneId: 'Z002',
        relayChannel: 2,
        type: 'Fan',
        isOn: false,
        powerUsage: 0.45),
    DeviceModel(
        deviceId: 'DEV003',
        deviceName: 'Kitchen Socket',
        zoneId: 'Z003',
        relayChannel: 3,
        type: 'Socket',
        isOn: true,
        powerUsage: 0.30),
    DeviceModel(
        deviceId: 'DEV004',
        deviceName: 'Water Heater',
        zoneId: 'Z004',
        relayChannel: 4,
        type: 'Socket',
        isOn: false,
        powerUsage: 1.20),
    DeviceModel(
        deviceId: 'DEV005',
        deviceName: 'Outdoor Light',
        zoneId: 'Z005',
        relayChannel: 5,
        type: 'Light',
        isOn: false,
        powerUsage: 0.20),
    DeviceModel(
        deviceId: 'DEV006',
        deviceName: 'Bedroom Light',
        zoneId: 'Z002',
        relayChannel: 6,
        type: 'Light',
        isOn: true,
        powerUsage: 0.15),
  ];

  // ============ ZONES ============
  static List<ZoneModel> get zones => [
        ZoneModel(
            zoneId: 'Z001',
            zoneName: 'Living Room',
            devices: devices.where((d) => d.zoneId == 'Z001').toList()),
        ZoneModel(
            zoneId: 'Z002',
            zoneName: 'Bedroom',
            devices: devices.where((d) => d.zoneId == 'Z002').toList()),
        ZoneModel(
            zoneId: 'Z003',
            zoneName: 'Kitchen',
            devices: devices.where((d) => d.zoneId == 'Z003').toList()),
        ZoneModel(
            zoneId: 'Z004',
            zoneName: 'Bathroom',
            devices: devices.where((d) => d.zoneId == 'Z004').toList()),
        ZoneModel(
            zoneId: 'Z005',
            zoneName: 'Outdoor',
            devices: devices.where((d) => d.zoneId == 'Z005').toList()),
      ];

  // ============ SCHEDULES ============
  static List<ScheduleModel> schedules = [
    ScheduleModel(
        scheduleId: 'SCH001',
        deviceId: 'DEV001',
        deviceName: 'Morning Lights',
        action: 'ON',
        triggerTime: '06:00 AM',
        repeatDays: 'Everyday'),
    ScheduleModel(
        scheduleId: 'SCH002',
        deviceId: 'DEV002',
        deviceName: 'Evening Fan',
        action: 'ON',
        triggerTime: '06:00 PM',
        repeatDays: 'Weekdays'),
    ScheduleModel(
        scheduleId: 'SCH003',
        deviceId: 'DEV004',
        deviceName: 'Night Mode',
        action: 'OFF',
        triggerTime: '10:00 PM',
        repeatDays: 'Everyday',
        isActive: false),
    ScheduleModel(
        scheduleId: 'SCH004',
        deviceId: 'DEV005',
        deviceName: 'Weekend Mode',
        action: 'ON',
        triggerTime: '08:00 AM',
        repeatDays: 'Weekends'),
  ];

  // ============ ALERTS ============
  static List<AlertModel> alerts = [
    AlertModel(
        alertId: 1,
        message: 'You left the lights on',
        type: 'Usage Pattern',
        createdAt: DateTime.now().subtract(const Duration(minutes: 15))),
    AlertModel(
        alertId: 2,
        message: 'Motion detected at Front Door',
        type: 'Security',
        createdAt: DateTime.now().subtract(const Duration(hours: 1))),
    AlertModel(
        alertId: 3,
        message: 'High Temperature in Bedroom (32°C)',
        type: 'Threshold',
        createdAt: DateTime.now().subtract(const Duration(hours: 3))),
    AlertModel(
        alertId: 4,
        message: 'Water Heater turned off',
        type: 'Usage Pattern',
        createdAt: DateTime.now().subtract(const Duration(days: 1))),
    AlertModel(
        alertId: 5,
        message: 'Morning Lights schedule executed',
        type: 'Usage Pattern',
        createdAt: DateTime.now().subtract(const Duration(days: 1))),
  ];

  // ============ USERS ============
  static List<UserModel> users = [
    UserModel(
        uid: 1,
        displayName: 'Rodel S. Salit',
        email: 'rodel@cc.ai',
        role: 'Admin',
        status: 'Approved'),
    UserModel(
        uid: 2,
        displayName: 'Lea Olasiman',
        email: 'lea@cc.ai',
        role: 'Family Member',
        status: 'Approved'),
    UserModel(
        uid: 3,
        displayName: 'Julius Lagarto',
        email: 'julius@cc.ai',
        role: 'Family Member',
        status: 'Approved'),
    UserModel(
        uid: 4,
        displayName: 'Kent Manayon',
        email: 'kent@cc.ai',
        role: 'Family Member',
        status: 'Approved'),
    UserModel(
        uid: 5,
        displayName: 'Liezel Boyoro',
        email: 'liezel@cc.ai',
        role: 'Elderly',
        status: 'Approved'),
    UserModel(
        uid: 6,
        displayName: 'New User',
        email: 'new@cc.ai',
        role: 'Family Member',
        status: 'Pending'),
  ];

  // ============ ENVIRONMENT ============
  static Map<String, double> environment = {
    'temperature': 26.5,
    'humidity': 60.0,
    'pressure': 1012.0,
  };

  // ============ ENERGY ============
  static Map<String, dynamic> energyReport = {
    'totalKwh': 2.45,
    'topDevices': [
      {'name': 'Water Heater', 'kwh': 1.20},
      {'name': 'Living Room Light', 'kwh': 0.80},
      {'name': 'Bedroom Fan', 'kwh': 0.45},
    ],
    'hourlyData': [
      0.1,
      0.2,
      0.15,
      0.3,
      0.5,
      0.7,
      0.6,
      0.4,
      0.3,
      0.2,
      0.15,
      0.1
    ],
  };
}
