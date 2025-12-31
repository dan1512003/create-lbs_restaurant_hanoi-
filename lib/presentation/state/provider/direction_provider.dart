// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:restaurant/data/repositories/search_repository.dart';
import 'package:restaurant/data/services/routing_service.dart';


import '../../../data/model/restaurant.dart';
import '../../../core/constants/restaurant_utils.dart';
import '../../../data/model/nominatimplace.dart';

class DirectionProvider extends ChangeNotifier {

   final  SearchRepository  repositoryservice;
   final RoutingRepository routingrepository;


  DirectionProvider({required this.repositoryservice,required this.routingrepository});
 
  



  List<NominatimPlace> results = [];
  RouteResult? routeResult;
   Restaurant? resultsrestaurnt ;
 
   LatLng? currentLocation;

  bool isLoading = false;




    Future<void> getRoute(LatLng start, LatLng end) async {     
      routeResult = await routingrepository.getRoute(start, end);
 if(routeResult==null){
  print("rỗng");
 }else{
   print("${routeResult?.durationText}");
 }
  notifyListeners(); 
    }
void updateCurrentLocation(LatLng pos) {
  currentLocation = pos;
  notifyListeners(); 
}
  Future<void> updateRestaurant(Restaurant restaurant) async {
    resultsrestaurnt = restaurant;
    notifyListeners(); 
  }
  Future<void> search(String query) async {
    if (query.isEmpty) return;



    try {
      final datanominatimplace = await repositoryservice.searchPlace(query);
      final datarestaurant = await repositoryservice.getrestaurant();
  

      final List featuresnominatimplace = datanominatimplace['features'];
      final List featuresrestaurant = datarestaurant['features'];
    

      
      final listrestaurant = featuresrestaurant
          .map<Restaurant>((f) => Restaurant.fromFeature(f))
          .toList();

     
      final listnominatimplace = featuresnominatimplace
          .where((f) {
            final p = f['properties'];
            if (p == null) return false;

            return (p['category'] == 'amenity' && p['type'] == 'restaurant') ;
          })
          .map<NominatimPlace>((f) => NominatimPlace.fromJson(f))
          .toList();

      final restaurantMap = {for (var r in listrestaurant) r.osmId: r};
    

      results = listnominatimplace
          .where((np) =>
              restaurantMap.containsKey(np.osmId))
          .toList();
    } catch (e) {
      print('Lỗi khi search: $e');
      results = [];
    }


    notifyListeners();
  }

  void clear() {
     results = [];
   
  
    notifyListeners();
  }

  
  // FIND BY SEARCH
 
  Future<void> findbysearch(
    MapController mapController, {
    double zoom = 15,
  }) async {
    if (results.isEmpty || isLoading ==true) return;

isLoading=true;
 notifyListeners();
    try {
      List<Restaurant> restaurantdata=[];
     for (final amenity in results) {
          final data = await repositoryservice.getrestaurantID(int.parse(amenity.osmId));
          final List featuresrestaurant = data['features'];

         restaurantdata.addAll(featuresrestaurant.map((f) => Restaurant.fromFeature(f)));
        }
         final restaurantMap = await addReviewtoRestaurant( restaurantdata, repositoryservice);
         resultsrestaurnt= restaurantMap.values.toList().first;
      await getRoute(currentLocation!, LatLng(resultsrestaurnt!.lat, resultsrestaurnt!.lon) );

      mapController.move(
        LatLng(resultsrestaurnt!.lat, resultsrestaurnt!.lon),
        zoom,
      );
      clear();
      isLoading=false;
       notifyListeners();
    } catch (e) {
      print('Lỗi findbysearch: $e');
    
       isLoading=false;
       clear();
    }
  }


  // FIND BY PICK

  Future<void> findbypick(
    NominatimPlace nominatimplace,
    TextEditingController searchController,
    MapController mapController, {
    double zoom = 15,
  }) async {
      if ( isLoading ==true) return;
       isLoading=true;
       clear();
      searchController.text = nominatimplace.displayName;
     

    try {
    
     List<Restaurant> restaurantdata=[];
    final data = await repositoryservice.getrestaurantID(int.parse(nominatimplace.osmId));
        final List featuresrestaurant = data['features'];

       restaurantdata =featuresrestaurant.map((f) => Restaurant.fromFeature(f)).toList();
       final restaurantMap = await addReviewtoRestaurant( restaurantdata, repositoryservice);
         resultsrestaurnt= restaurantMap.values.toList().first;
         await getRoute(currentLocation!, LatLng(nominatimplace.lat, nominatimplace.lon) );
  mapController.move(
      LatLng(nominatimplace.lat, nominatimplace.lon),
      zoom,
    );
      isLoading =false;
      notifyListeners();
    } catch (e) {
      print(' Lỗi findbypick: $e');
    isLoading =false;
    clear();
    }
  }







}
