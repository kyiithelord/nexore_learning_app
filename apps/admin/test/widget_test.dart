import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:nexora_admin/main.dart';

void main() {
  testWidgets('shows Nexora admin dashboard', (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(const App());
    expect(find.text('nexora.'), findsOneWidget);
    expect(find.text('Active learners'), findsOneWidget);
  });
}
