// import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:scnu_jwxt_pdf2ics/Page/ConverDonePage.dart';
import 'package:scnu_jwxt_pdf2ics/Page/DebugPage.dart';
import 'package:scnu_jwxt_pdf2ics/Page/MainPage.dart';
import 'package:scnu_jwxt_pdf2ics/Page/PdfLoadedPage.dart';
import 'package:scnu_jwxt_pdf2ics/util/LocalizationState.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationApp extends StatelessWidget {
  const LocalizationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // pass supportedLocals

    var localizationState = context.read<LocalizationState>();
    localizationState.supportedLocals = AppLocalizations.supportedLocales;
    localizationState.setLocalById();

    return Consumer<LocalizationState>(
        builder: (context, LocalizationState, child) => MaterialApp(
              home: MainPage(),
              routes: {
                PdfLoadedPage.routeName: (BuildContext context) =>
                    PdfLoadedPage(),
                ConverDonePage.routeName: (BuildContext context) =>
                    ConverDonePage(),
                DebugPage.routeName: (BuildContext context) => DebugPage()
              },

              //多语言
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: LocalizationState.local,
              // localeListResolutionCallback:
              //     (List<Locale>? locales, Iterable<Locale> supportLocales) {
              //   print('locales:$locales');
              //   print('supportLocales:$supportLocales');
              // },
              supportedLocales: [
                const Locale.fromSubtags(languageCode: 'en'),

                // Full Chinese support for CN, TW, and HK
                const Locale.fromSubtags(languageCode: 'zh'), // generic Chinese
                const Locale.fromSubtags(
                    languageCode: 'zh',
                    scriptCode: 'Hans'), // generic simplified Chinese
                const Locale.fromSubtags(
                    languageCode: 'zh',
                    scriptCode: 'Hant'), // generic traditional Chinese
                const Locale.fromSubtags(
                    languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
                const Locale.fromSubtags(
                    languageCode: 'zh', scriptCode: 'Hant', countryCode: 'HK'),
                const Locale.fromSubtags(
                    languageCode: 'zh', scriptCode: 'Hant', countryCode: 'MO'),
              ],
            ));
  }
}
