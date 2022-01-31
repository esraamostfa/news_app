import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SportsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var list = AppCubit.get(context).sportsNews;

    return Padding(
      padding: const EdgeInsets.all(21.0),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) => buildListView(list, state != AppGetSportsNewsLoadingState()),
      ),
    );
  }
}
