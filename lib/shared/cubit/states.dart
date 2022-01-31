abstract class AppStates {}

class AppInitialState extends AppStates {}
class AppBottomNaveState extends AppStates {}

class AppChangeModeState extends AppStates {}

class AppGetBusinessNewsLoadingState extends AppStates {}
class AppGetBusinessNewsSuccess extends AppStates {}
class AppGetBusinessNewsError extends AppStates {

  final String error;
  AppGetBusinessNewsError(this.error);
}

class AppGetSportsNewsLoadingState extends AppStates {}
class AppGetSportsNewsSuccess extends AppStates {}
class AppGetSportsNewsError extends AppStates {

  final String error;
  AppGetSportsNewsError(this.error);
}

class AppGetScienceNewsLoadingState extends AppStates {}
class AppGetScienceNewsSuccess extends AppStates {}
class AppGetScienceNewsError extends AppStates {

  final String error;
  AppGetScienceNewsError(this.error);
}

class AppGetSearchLoadingState extends AppStates {}
class AppGetSearchSuccess extends AppStates {}
class AppGetSearchError extends AppStates {

  final String error;
  AppGetSearchError(this.error);
}