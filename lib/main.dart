import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/layout/layout_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
          ),
          elevation: 0,
          // backwardsCompatibility: false,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          color: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          elevation: 20,
          backgroundColor: Colors.white
        ),
        scaffoldBackgroundColor: Colors.white
      ),
      home: const NewsLayoutScreen(),
    );
  }
}

