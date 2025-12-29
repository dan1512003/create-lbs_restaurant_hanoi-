import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'presentation/state/provider/search_provider.dart';
import 'presentation/screens/homenavigator.dart';
import 'presentation/screens/settingnavigator.dart';
import 'presentation/screens/searchnavigtor.dart';
import 'presentation/screens/savenavigator.dart';
import 'presentation/state/provider/home_provider.dart';
import 'presentation/state/provider/restaurant_town_provider.dart';
import 'presentation/state/provider/restaurant_cuisine_provider.dart';
import 'presentation/state/provider/user_provider.dart';
import 'presentation/state/provider/restaurant_provider.dart';
import 'presentation/state/provider/direction_provider.dart';
import 'presentation/state/provider/geolocator_provider.dart';

void main() {
  // ❌ Tắt toàn bộ debug log
  debugPrint = (String? message, {int? wrapWidth}) {};

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantTownProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantCuisineProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
        ChangeNotifierProvider(create: (_) => DirectionProvider()),
        ChangeNotifierProvider(create: (_) => GeolocatorProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Homenavigator(),
    Searchnavigtor(),
    Savenavigator(),
    Settingnavigator(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().checkToken();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
    
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Save',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}
