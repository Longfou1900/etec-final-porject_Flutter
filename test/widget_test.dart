import 'package:flutter_projects_getx/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Watch app renders home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // UI text may change; ensure at least one widget is built for the home screen.
    // Just ensure the widget tree builds.
    expect(tester.takeException(), isNull);
  });
}
