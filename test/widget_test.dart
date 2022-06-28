import 'package:flutter_test/flutter_test.dart';
import 'package:auto_rng/main.dart';

void main() {
  testWidgets('Main Page Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app has the title listed.
    expect(find.text('List Mix'), findsOneWidget);
  });
}
