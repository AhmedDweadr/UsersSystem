import 'package:flutter/material.dart';
import 'package:my_app/generated/l10n.dart';
import 'package:my_app/view/Homepage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(MyApp());
}

class UserRemoteDataSource {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale('ar'),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Homepage(),
    );
  }
}
