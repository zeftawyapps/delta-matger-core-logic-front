// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:matger_core_logic/utls/test_widgets/test_widget.dart';

void main() {
  testWidgets('Logic Dashboard loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LogicTesterApp());

    // Verify that the dashboard title is present
    expect(find.text('🚀 Matger Core Logic'), findsOneWidget);

    // Check if some action buttons are present
    expect(find.text('Test API'), findsOneWidget);
    expect(find.text('Auth Logic'), findsOneWidget);
  });
}
