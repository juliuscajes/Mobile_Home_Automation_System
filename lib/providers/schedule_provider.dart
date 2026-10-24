import 'package:flutter/material.dart';
import '../data/models/schedule_model.dart';
import '../data/mock/mock_data.dart';

class ScheduleProvider extends ChangeNotifier {
  final List<ScheduleModel> _schedules = List.from(MockData.schedules);
  List<ScheduleModel> get schedules => _schedules;

  void toggleSchedule(String id) {
    final i = _schedules.indexWhere((s) => s.scheduleId == id);
    if (i != -1) {
      _schedules[i].isActive = !_schedules[i].isActive;
      notifyListeners();
    }
  }

  void deleteSchedule(String id) {
    _schedules.removeWhere((s) => s.scheduleId == id);
    notifyListeners();
  }
}
