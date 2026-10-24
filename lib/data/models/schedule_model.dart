class ScheduleModel {
  final String scheduleId;
  final String deviceId;
  final String deviceName;
  final String action; // ON or OFF
  final String triggerTime; // e.g., "06:00 AM"
  final String repeatDays; // e.g., "Everyday", "Weekdays"
  bool isActive;

  ScheduleModel({
    required this.scheduleId,
    required this.deviceId,
    required this.deviceName,
    required this.action,
    required this.triggerTime,
    required this.repeatDays,
    this.isActive = true,
  });
}
