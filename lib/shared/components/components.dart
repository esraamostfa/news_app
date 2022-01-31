import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget buildNewsArticleItem({
  @required item,
  @required context
}) => InkWell(
  onTap: () {
    naveTo(context, WebViewScreen('${item['url']}'));
  },
  child:   Row(

      children: [

        Container(

          height: 121,

          width: 121,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(11.0),

            image:

                DecorationImage(image: NetworkImage('${item['urlToImage']}'),

                    fit: BoxFit.cover),

          ),

        ),

        SizedBox(

          width: 21,

        ),

        Expanded(

          child: Container(

            height: 121,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              //mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Expanded(

                  child: Text(

                    item['title'],

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                    style: Theme.of(context).textTheme.bodyText1,

                  ),

                ),

                Text(

                  item['publishedAt'],

                  style: TextStyle(

                    color: Colors.grey,

                  ),

                )

              ],

            ),

          ),

        )

      ],

    ),
);


Widget buildItemsDivider() => Container(
      height: 1,
      color: Colors.grey[300],
      margin: EdgeInsets.all(21),
    );

Widget buildListView(List<dynamic> list, condition) => ConditionalBuilder(
  condition: condition  ,
  builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildNewsArticleItem(item: list[index], context: context),
      separatorBuilder: (context, index) => buildItemsDivider(),
      itemCount: list.length),
  fallback: (context) => Center(child: CircularProgressIndicator()) ,
);

Widget defaultTextForm({
  @required controller,
  @required textInputType,
  onSubmit,
  onChange,
  @required String? label,
  @required validator,
  @required IconData? prefixIcon,
  IconData? suffixIcon,
  bool isPassword = false,
  onTape,
  bool isEnabled = true,

}) =>
    TextFormField(
      controller: controller,
      keyboardType: textInputType,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validator,
      onTap: onTape,
      enabled: isEnabled,
      obscureText: isPassword,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          border: OutlineInputBorder()),
    );

void naveTo(context, widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget));
}
