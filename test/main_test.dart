import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:restaurant/main.dart';
import 'package:restaurant/presentation/state/provider/direction_provider.dart';
import 'package:restaurant/presentation/state/provider/geolocator_provider.dart';
import 'package:restaurant/presentation/state/provider/home_provider.dart';
import 'package:restaurant/presentation/state/provider/restaurant_cuisine_provider.dart';
import 'package:restaurant/presentation/state/provider/restaurant_town_provider.dart';
import 'package:restaurant/presentation/state/provider/user_provider.dart';
import 'package:restaurant/presentation/state/provider/search_provider.dart';
import 'package:restaurant/presentation/state/provider/restaurant_provider.dart';

import 'mock/localstore_mock.dart';
import 'mock/routing_mock.dart';
import 'mock/search_mock.dart';

void main() {
  final searchService = SearchMock();
  final routingService = RoutingMock();
  final localstoreService = LocalstoreMock();

  Widget createApp() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SearchProvider(repository: searchService),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(repository: searchService),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantTownProvider(repository: searchService),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantCuisineProvider(repository: searchService),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(
            repositoryservice: searchService,
            localstoreservice: localstoreService,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(repository: searchService),
        ),
        ChangeNotifierProvider(
          create: (_) => DirectionProvider(
            repositoryservice: searchService,
            routingrepository: routingService,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => GeolocatorProvider(),
        ),
      ],
      child: const MyApp(),
    );
  }

  testWidgets('Home tab', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.home), findsOneWidget);
    });
  });

  testWidgets('Search tab', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.search), findsOneWidget);
    });
  });

  testWidgets('Save tab', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.bookmark), findsOneWidget);
    });
  });

  testWidgets('Setting tab', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });
  });
}
