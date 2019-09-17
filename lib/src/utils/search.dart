import 'package:flutter/material.dart';
import 'package:nux_movie/src/widgets/search_query_card.dart';

class MovieSearch extends SearchDelegate<String> {
  var suggestionList = [
    'Batman begins',
    'The dark knight',
    'The dark knight rises',
    'Watchmen',
    'Man of steel',
    'Inception',
    'Mad max',
    'Memento',
    'Dunkirk',
    'Interstellar',
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = ThemeData.dark();
    return theme;
  }


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query='';
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
    return SearchCard(query: query,page: 1,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var list = suggestionList.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: (){
            query=list[index];
            showResults(context);
          },
          leading: Icon(Icons.movie),
          title: RichText(
            text: TextSpan(
              text: list[index].substring(0, query.length),
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,),
              children: [TextSpan(
                text: list[index].substring(query.length),
                style: TextStyle(color: Colors.grey),
              ),]
            ),
          ),
        );
      },
      itemCount: list.length,
    );
  }
}
