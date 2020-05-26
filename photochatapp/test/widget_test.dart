import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photochatapp/app/app.dart';
import 'package:photochatapp/services/context/app_context.dart';
import 'package:photochatapp/services/states/app_running_states.dart';
import 'package:photochatapp/services/theme/base_theme_service.dart';
import 'package:photochatapp/services/theme/mock_theme_service.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    AppTheme appTheme = MockAppTheme();
    AppContext appContext =
        AppContext(appRunningStateOverride: AppRunningState.UNIT_TEST);
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => appTheme),
          ChangeNotifierProvider(create: (context) => appContext),
        ],
        child: PhotoChatApp(),
      ),
    );
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.byKey(Key('home_screen_encode_message_btn')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('send_screen_back_btn')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('home_screen_decode_message_btn')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('receive_screen_back_btn')));
    await tester.pumpAndSettle();
  });
}
