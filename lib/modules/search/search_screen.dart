import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    var searchController = TextEditingController();

    var list = AppCubit.get(context).searchResults;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(19.0),
              child: defaultTextForm(
                  controller: searchController,
                  textInputType: TextInputType.text,
                  onChange: (value) {
                    AppCubit.get(context).getSearchResults(value);
                  },
                  label: 'search',
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'search can\'t be null';
                    } else {
                      return null;
                    }
                  },
                  prefixIcon: Icons.search),
            ),
            Expanded(child: buildListView(list, list.length > 0)),
          ],
        ),
      ),
    );
  }
}
