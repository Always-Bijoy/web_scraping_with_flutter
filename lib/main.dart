import 'package:flutter/material.dart';
import 'package:web_scraping_with_flutter/jago_news_bd.dart';
import 'package:web_scraping_with_flutter/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JagoNewsBd(),
    );
  }
}
