import 'package:flutter_test/flutter_test.dart';
import 'package:skinotic_new/main.dart';

void main() {
  testWidgets('SKINOTIC app loads successfully',
      (WidgetTester tester) async {

    await tester.pumpWidget(const SkinoticApp());

    expect(find.byType(SkinoticApp), findsOneWidget);
  });
}
