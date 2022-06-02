import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/moduels/business_screen/business_screen.dart';
import 'package:news_app/moduels/science_screen/science_screen.dart';
import 'package:news_app/moduels/settings_screen/settings_screen.dart';
import 'package:news_app/moduels/sports_screen/sports.dart';

class NewsCubit extends Cubit<NewsAppStates> {
  NewsCubit() : super(NewsAppInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screen = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingsScreen(),
  ];

  List<BottomNavigationBarItem> botNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business'
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void changeBotNavBarIndex(index){
    currentIndex = index;

    emit(NewsAppBotNavState());
  }
}