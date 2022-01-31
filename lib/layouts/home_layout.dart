import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, status) {},
      builder: (context, status) {

        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  naveTo(context, SearchScreen());
                },
              ),
              IconButton(
                icon: Icon(Icons.brightness_4_outlined),
                onPressed: () {
                  cubit.changeMode();
                },
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavIndex(index);
            },
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      }
    );
  }
}
