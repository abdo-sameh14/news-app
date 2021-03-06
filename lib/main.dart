import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/layout/layout_screen.dart';
import 'package:news_app/shared/network/local/chache%20_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'shared/styles/bloc_observer.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // final prefs = await SharedPreferences.getInstance();
      // show = prefs.getBool('INTRODUCTION') ?? true;

      if (Platform.isWindows) {
        await DesktopWindow.setMinWindowSize(
          const Size(500, 700),
        );
      }

      DioHelper.init();
      await CacheHelper.init();
      final bool? isDark = CacheHelper?.getBool(key: 'isDark');
      runApp(MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp(this.isDark, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getBusiness()
        ..toggleDarkMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsAppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          bool darkModeOn = NewsCubit.get(context).darkMode;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                titleSpacing: 20,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                elevation: 0,
                // backwardsCompatibility: false,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                color: Colors.white,
                titleTextStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey[600],
                  elevation: 20,
                  backgroundColor: Colors.white),
              scaffoldBackgroundColor: Colors.white,
              textTheme: TextTheme(
                bodyText1: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                bodyText2: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[500]),
              ),
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.deepOrange,
              ).copyWith(secondary: Colors.grey[300]),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Color(0xff121212),
                    statusBarIconBrightness: Brightness.light),
                elevation: 0,
                // backwardsCompatibility: false,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                color: Colors.grey[900],
                titleTextStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20,
                backgroundColor: Colors.grey[900],
              ),
              scaffoldBackgroundColor: const Color(0xff121212),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(.87)),
                bodyText2: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.6)),
              ),
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.deepOrange,
              ).copyWith(secondary: Colors.grey[600]),
            ),
            themeMode: darkModeOn ? ThemeMode.dark : ThemeMode.light,
            home: AnimatedSplashScreen(
              splash: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset(
                      'assets/images/app-logo.png',
                      scale: 8,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Akhbarak',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(.87)),
                    ),
                    // SizedBox(
                    //   height: 100,
                    // ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 55,
                      height: 55,
                    ),
                  ],
                ),
              ),
              nextScreen: const NewsLayoutScreen(),
              backgroundColor: const Color(0xff212121),
              // darkModeOn ? const Color(0xff212121) : Colors.white.withOpacity(.87),
              animationDuration: const Duration(seconds: 1),
              // splashTransition: SplashTransition.,
              // centered: true,
              pageTransitionType: PageTransitionType.fade,
              duration: 2000,
              splashIconSize: double.infinity,
            ),
            // const NewsLayoutScreen(),
          );
        },
      ),
    );
  }
}
