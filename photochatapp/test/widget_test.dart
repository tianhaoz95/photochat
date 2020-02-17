import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photochatapp/app/app.dart';
import 'package:photochatapp/services/states/app_running_states.dart';

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(PhotoChatApp(AppRunningState.UNIT_TEST));
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
