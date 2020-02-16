import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photochatapp/app.dart';

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(PhotoChatApp());
    await tester.tap(find.byKey(Key('home_screen_encode_message_btn')));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('home_screen_decode_message_btn')));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
  });
}
