import 'package:flutter_projects_getx/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Watch app renders home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Watch ETEC'), findsOneWidget);
  });
}
