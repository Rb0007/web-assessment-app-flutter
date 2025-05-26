import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_iframe_dashboard/main.dart';

void main() {
  testWidgets('Renders navigation buttons and pages', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Iframe'), findsOneWidget);
    expect(find.text('Static'), findsOneWidget);

    await tester.tap(find.text('Iframe'));
    await tester.pump();
    expect(
      find.text('Form Iframe'),
      findsNothing,
    ); // since iframe is not a Flutter widget
  });
}
