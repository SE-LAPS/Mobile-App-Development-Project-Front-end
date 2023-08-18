import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_food_app/l10n/app_localizations.dart';

void main() {
  runApp(dinedelishApp());
}

class dinedelishApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dine delish App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LanguageSelectionPage(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('si', ''),
        const Locale('ta', ''),
      ],
    );
  }
}

class LanguageSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('select_language')!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _changeLanguage(context, 'en'),
              child: Text(AppLocalizations.of(context)!.translate('english')!),
            ),
            ElevatedButton(
              onPressed: () => _changeLanguage(context, 'si'),
              child: Text(AppLocalizations.of(context)!.translate('sinhala')!),
            ),
            ElevatedButton(
              onPressed: () => _changeLanguage(context, 'ta'),
              child: Text(AppLocalizations.of(context)!.translate('tamil')!),
            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage(BuildContext context, String languageCode) {
    AppLocalizations.of(context)!.load(Locale(languageCode, ''));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('welcome')!),
      ),
      // Your food ordering app UI goes here
    );
  }
}
