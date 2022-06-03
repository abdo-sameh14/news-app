import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/layout/layout_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared/styles/bloc_observer.dart';

void main() async {
  BlocOverrides.runZoned(
        () async {
      // WidgetsFlutterBinding.ensureInitialized();
      // final prefs = await SharedPreferences.getInstance();
      // show = prefs.getBool('INTRODUCTION') ?? true;
          DioHelper.init();
          runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
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
      home: Directionality(
          textDirection: TextDirection.rtl,
          child: const NewsLayoutScreen()),
    );
  }
}

