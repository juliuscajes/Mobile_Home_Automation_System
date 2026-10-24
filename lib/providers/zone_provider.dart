import 'package:flutter/material.dart';
import '../data/models/zone_model.dart';
import '../data/mock/mock_data.dart';

class ZoneProvider extends ChangeNotifier {
  List<ZoneModel> get zones => MockData.zones;
}
