import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:matger_core_logic/utls/test_widgets/test_widget.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end test', () {
    testWidgets('Verify full app flow', (WidgetTester tester) async {
      // Load the app
      await tester.pumpWidget(const LogicTesterApp());

      // Wait for initial load
      await tester.pumpAndSettle();

      // Verify initial UI state
      expect(find.text('🚀 Matger Core Logic'), findsOneWidget);

      // Trigger a reload
      final reloadButton = find.text('Reload Settings');
      await tester.tap(reloadButton);

      // Wait for any animations or state changes
      await tester.pumpAndSettle();

      // Scroll the log view if needed
      final logList = find.byType(ListView).last;
      await tester.drag(logList, const Offset(0, -300));
      await tester.pumpAndSettle();

      // Verify if test auth button works (at least doesn't crash)
      final testAuthButton = find.text('Test Auth');
      await tester.tap(testAuthButton);
      await tester.pumpAndSettle();

      expect(find.textContaining('Attempting Login'), findsWidgets);
    });
  });
}
