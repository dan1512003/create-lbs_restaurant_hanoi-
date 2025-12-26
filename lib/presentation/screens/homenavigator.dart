import 'package:flutter/material.dart';
import 'home_page.dart';
class Homenavigator extends StatelessWidget {
  const Homenavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
   

        return MaterialPageRoute(
          builder: (_) => HomePage(title: 'Home'),
          settings: settings,
        );
      },
    );
  }
}
