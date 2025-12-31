import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/phone_page.dart';
import '../screens/user/user_page.dart';
import '../state/provider/user_provider.dart';

class Settingnavigator extends StatelessWidget {
  const Settingnavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key:Key('setting_page'),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            final userProvider = context.watch<UserProvider>();

           
            return userProvider.token.isEmpty
                ? const PhonePage()
                : const UserPage();
          },
        );
      },
    );
  }
}
