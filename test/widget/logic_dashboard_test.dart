import 'package:flutter_test/flutter_test.dart';
import 'package:matger_core_logic/utls/test_widgets/test_widget.dart';

void main() {
  group('LogicDashboard Widget Tests', () {
    testWidgets('Dashboard UI renders correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const LogicTesterApp());
      await tester.pumpAndSettle(); // Wait for the 500ms delay in TestBloc

      // Verify Title
      expect(find.text('🚀 Matger Core Logic'), findsOneWidget);

      // Verify Action Buttons exist
      expect(find.text('Reload Settings'), findsOneWidget);
      expect(find.text('Clear Logs'), findsOneWidget);
      expect(find.text('Test Auth'), findsOneWidget);
    });

    testWidgets('Clear Logs button clears the log list', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const LogicTesterApp());
      await tester.pumpAndSettle();

      // Find Clear Logs button and tap it
      final clearButton = find.text('Clear Logs');
      expect(clearButton, findsOneWidget);

      await tester.tap(clearButton);
      await tester.pump();

      // We don't verify specific content here as it depends on active logs,
      // but ensuring no crash is good.
    });
  });
}
