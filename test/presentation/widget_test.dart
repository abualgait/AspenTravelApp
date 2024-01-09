// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aspen_app/core/utils/pref_utils.dart';
import 'package:aspen_app/injection_container.dart' as di;
import 'package:aspen_app/main.dart';

void main() {
  testWidgets('Explore clicked open Home Screen',
      (WidgetTester tester) async {
    PrefUtils().init();
    di.init();
    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(child: MyApp()));

    expect(find.text('Explore'), findsOneWidget);

    await tester.tap(find.text('Explore'));
    await tester.pump();

  });
}
