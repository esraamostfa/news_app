import 'package:bloc/bloc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layouts/home_layout.dart';
import 'package:news_app/shared/cubit/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();
  //bool? isDark = CacheHelper.getBoolData('isDark');

  await DesktopWindow.setMinWindowSize(Size(451, 651));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  //final bool? isDark;
  //MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
          create: (context) => AppCubit()..getBusinessNews()..getSportsNews()..getScienceNews(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {

        } ,
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return MaterialApp(
            // builder:  (context, widget) => ResponsiveWrapper.builder(
            //     BouncingScrollWrapper.builder(context, widget!),
            //     maxWidth: 1200,
            //     minWidth: 480,
            //     defaultScale: true,
            //     breakpoints: [
            //       ResponsiveBreakpoint.resize(480, name: MOBILE),
            //       ResponsiveBreakpoint.autoScale(800, name: TABLET),
            //       ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            //     ],
            //     background: Container(
            //         color: Color(0xFFF5F5F5)
            //     )
            // ),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                  titleSpacing: 21,
                    color: Colors.white,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold),
                    iconTheme: IconThemeData(color: Colors.black),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    )),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 21,
                ),
                scaffoldBackgroundColor: Colors.white,
                textTheme: TextTheme(bodyText1: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ))
            ),
            darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                  titleSpacing: 21,
                    color: HexColor('333739'),
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold),
                    iconTheme: IconThemeData(color: Colors.white),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light,
                    )),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: HexColor('333739'),
                  elevation: 21,
                ),
                scaffoldBackgroundColor: HexColor('333739'),
                textTheme: TextTheme(bodyText1: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ))
            ),
            themeMode: cubit.darkMode? ThemeMode.dark : ThemeMode.light,
            home: ScreenTypeLayout(
              mobile: HomeLayout(),
              desktop: Text('Desktop'),
              breakpoints: ScreenBreakpoints(
                desktop: 651.0,
                tablet: 351.0,
                watch: 35.0
              ),
            ),
          );
        },
      ),
    );
  }
}
