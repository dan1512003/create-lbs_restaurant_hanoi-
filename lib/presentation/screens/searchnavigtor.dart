import 'package:flutter/material.dart';
import 'search_page.dart';

class Searchnavigtor extends StatelessWidget {
  const Searchnavigtor({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key:Key('search_page'),
      onGenerateRoute: (settings) {
        

        return MaterialPageRoute(
          builder: (_) => SearchPage(),
          settings: settings,
        );
      },
    );
  }
}
