import 'package:flutter/material.dart';
import 'package:settingpage/about_us_screen.dart';
import 'package:settingpage/privacy_policy_screen.dart';
import 'package:settingpage/settings_page.dart';
import 'package:settingpage/terms_and_condition_screen.dart';

import 'package:settingpage/screens/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Setting Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingPage(),
    );
  }
}

//about page

//privacy and policy
class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Privacy Policy Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrivacyPolicyScreen(),
    );
  }
}

//tearms and conditions
class TMyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Terms and Conditions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TermsConditionsScreen(),
    );
  }
}

//notification
class NotificationSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Order App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NotificationSettingsScreen(),
    );
  }
}

//dark mode
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Settings',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SettingsScreen(),
    );
  }
}

//order update page
class OrderUpdatesSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Order Update',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrderUpdatesSettingsScreen(),
    );
  }
}

//language select
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'si', 'ta'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return false;
  }
}

class AppLocalizations extends StatefulWidget {
  AppLocalizations(Locale locale);

  @override
  _AppLocalizationsState createState() => _AppLocalizationsState();
}

class _AppLocalizationsState extends State<AppLocalizations> {
  Locale _locale = Locale('en'); // Default language is English

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dine Delish App',
      theme: ThemeData(primarySwatch: Colors.blue),
      locale: _locale,
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('si'),
        const Locale('ta'),
      ],
      home: HomeScreen(changeLanguage: _changeLanguage),
    );
  }
}


class about extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Restaurant App'),
        ),
        body: Center(
          child: ElevatedButton(
           onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
            child: Text('About Us'),
          ),
        ),
      ),
    );
  }
}
