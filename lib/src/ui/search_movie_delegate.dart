import 'package:flutter/material.dart';
import 'package:nux_movie/src/constants/colors.dart';
import 'package:nux_movie/src/utils/store_search_query.dart';
import 'package:nux_movie/src/widgets/custom_text.dart';
import 'package:nux_movie/src/widgets/search_query_card.dart';

class SearchMovieDelegate extends SearchDelegate<String> {
  final StoreSearchQuery _storeSearchQuery;
  List<String> queryList;
  SearchMovieDelegate(this._storeSearchQuery) {
    queryList = _storeSearchQuery.getQueryList();
    queryList = queryList.reversed.toList();
  }
  @override
  ThemeData appBarTheme(BuildContext context) {
   final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Color(kPrimaryDarkColor),
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      textTheme: theme.textTheme.copyWith(title: TextStyle(color: Colors.white)),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Future<void> showResults(BuildContext context) async {
    print(query);
    if (query != '') {
      await _storeSearchQuery.storeQuery(query);
    }
    super.showResults(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchCard(
      query: query,
      page: 1,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var list = queryList.where((p) => p.startsWith(query)).toList();
    return Container(
      color: Color(kPrimaryColor),
      child: ListView.builder(
        itemCount: list.length + 1,
        itemBuilder: (_, index) {
          if (list.isEmpty) {
            return Container();
          } else if (index == list.length) {
            return GestureDetector(
              onTap: () async {
                await _storeSearchQuery.deleteAllQuery();
              },
              child: Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    'Clear history',
                    textColor: Colors.blue,
                    fontSize: 16,
                  )),
            );
          }
          return ListTile(
            leading: Icon(Icons.history),
            title: RichText(
              text: TextSpan(
                  text: list[index].substring(0, query.length),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: list[index].substring(query.length),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ]),
            ),
            trailing: Icon(Icons.call_made),
            onTap: () {
              query = list[index];
              showResults(context);
            },
          );
        },
      ),
    );
    
  }
}
