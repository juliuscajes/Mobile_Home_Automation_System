import 'package:flutter_test/flutter_test.dart';
import 'package:cc_smart_home/app.dart';
import 'package:cc_smart_home/providers/auth_provider.dart';
import 'package:cc_smart_home/providers/device_provider.dart';
import 'package:cc_smart_home/providers/zone_provider.dart';
import 'package:cc_smart_home/providers/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('App loads login screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => DeviceProvider()),
          ChangeNotifierProvider(create: (_) => ZoneProvider()),
          ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ],
        child: const CCSmartHomeApp(),
      ),
    );

    expect(find.text('LOGIN'), findsOneWidget);
  });
}
