import 'package:flutter/material.dart';
import 'save_page.dart';

class Savenavigator extends StatelessWidget {
  const Savenavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
 

        return MaterialPageRoute(
          builder: (_) => SavePage(),
          settings: settings,
        );
      },
    );
  }
}
