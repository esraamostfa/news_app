//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool darkMode = CacheHelper.getBoolData('isDark')?? false;

  void changeMode() {
    darkMode = !darkMode;
    CacheHelper.putBoolData('isDark', darkMode);
    emit(AppChangeModeState());
  }

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomNavItems = [
  BottomNavigationBarItem(
  icon: Icon(Icons.business),
  label: 'Business',),
  BottomNavigationBarItem(
  icon: Icon(Icons.science),
  label: 'Science',),
  BottomNavigationBarItem(
  icon: Icon(Icons.sports),
  label: 'Sports',),
    ];

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(AppBottomNaveState());
  }

  List<String> titles = ['Business News', 'Science News', 'Sports News'];
  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
  ];

  List<dynamic> businessNews = [];

  void getBusinessNews() {

    emit(AppGetBusinessNewsLoadingState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country' : 'eg',
          'category' : 'business',
          'apiKey' : 'dac0b5364faf41c5a06fb4afb701428d',
        }).then((value) {

          businessNews = value.data['articles'];
      print('Articles: ${businessNews.toString()}');
      emit(AppGetBusinessNewsSuccess());

    }).catchError((error) {
      print(error.toString());
      emit(AppGetBusinessNewsError(error.toString()));
    });
  }

  List<dynamic> sportsNews = [];

  void getSportsNews() {

    emit(AppGetSportsNewsLoadingState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country' : 'eg',
          'category' : 'sports',
          'apiKey' : 'dac0b5364faf41c5a06fb4afb701428d',
        }).then((value) {

      sportsNews = value.data['articles'];
      print('Articles: ${businessNews.toString()}');
      emit(AppGetSportsNewsSuccess());

    }).catchError((error) {
      print(error.toString());
      emit(AppGetSportsNewsError(error.toString()));
    });
  }

  List<dynamic> scienceNews = [];

  void getScienceNews() {

    emit(AppGetScienceNewsLoadingState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country' : 'eg',
          'category' : 'science',
          'apiKey' : 'dac0b5364faf41c5a06fb4afb701428d',
        }).then((value) {

      scienceNews = value.data['articles'];
      print('Articles: ${businessNews.toString()}');
      emit(AppGetScienceNewsSuccess());

    }).catchError((error) {
      print('Error getting Science news ${error.toString()}');
      emit(AppGetScienceNewsError(error.toString()));
    });
  }

  List<dynamic> searchResults = [];

  void getSearchResults(String value) {

    emit(AppGetSearchLoadingState());

    DioHelper.getData(
        url: 'v2/everyThing',
        query: {
          'q' : '$value',
          'apiKey' : 'dac0b5364faf41c5a06fb4afb701428d',
        }).then((value) {

      searchResults = value.data['articles'];
      emit(AppGetSearchSuccess());
      print('Articles: ${searchResults[0]['title']}');

    }).catchError((error) {
      print(error.toString());
      emit(AppGetSearchError(error.toString()));
    });
  }

}