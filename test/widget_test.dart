import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:argus_flutter/main.dart';

void main() {
  testWidgets('App load smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1290, 2796);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const ArgusApp());
    expect(find.byType(ArgusApp), findsOneWidget);
  });
}
