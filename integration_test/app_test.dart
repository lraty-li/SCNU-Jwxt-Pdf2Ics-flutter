import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:scnu_jwxt_pdf2ics/ExpandableFab.dart';

import 'package:scnu_jwxt_pdf2ics/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;
  //显示每一帧
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify every buttom',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final Finder CustomfloatingActionButton = find.byIcon(Icons.add);
      expect(CustomfloatingActionButton, findsOneWidget);
      await tester.tap(CustomfloatingActionButton);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // all sub page
      expect(find.byIcon(Icons.g_translate), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
      expect(find.byIcon(Icons.code), findsOneWidget);
      expect(find.byIcon(Icons.qr_code), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('tap on the choose pdf buttom', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final Finder uploadPdfButtom = find.byIcon(Icons.folder_open);
      expect(uploadPdfButtom, findsOneWidget);
      await tester.tap(uploadPdfButtom);

      await tester.pumpAndSettle();
    });
  });
}
