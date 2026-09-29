import 'package:flutter_test/flutter_test.dart';
import 'package:nexora_learner/main.dart';

void main() {
  testWidgets('shows learner home and starts a lesson', (tester) async {
    await tester.pumpWidget(const Nexora());
    expect(find.text('nexora'), findsOneWidget);
    expect(find.text('Continue lesson'), findsOneWidget);
    await tester.tap(find.text('Continue lesson'));
    await tester.pump();
    expect(find.text('QUESTION 1 OF 3'), findsOneWidget);
  });
}
