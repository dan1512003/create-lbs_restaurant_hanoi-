// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../data/services/search_service.dart';
import '../../../data/model/restaurant.dart';
import '../../../data/model/ward.dart';
import '../../../core/constants/restaurant_utils.dart';
import '../../../data/model/nominatimplace.dart';

class SearchProvider extends ChangeNotifier {
  final SearchService _service = SearchService();

  List<NominatimPlace> results = [];
  List<Restaurant> resultsrestaurnt = [];
  bool isLoading = false;
  LatLng? location;
  String error='';
  Future<void> search(String query) async {
    if (query.isEmpty) return;



    try {
      final datanominatimplace = await _service.searchPlace(query);
      final datarestaurant = await _service.getrestaurant();
      final dataward = await _service.getward();

      final List featuresnominatimplace = datanominatimplace['features'];
      final List featuresrestaurant = datarestaurant['features'];
      final List featuresward = dataward['features'];

      
      final listrestaurant = featuresrestaurant
          .map<Restaurant>((f) => Restaurant.fromFeature(f))
          .toList();

      final listward = featuresward
          .map<Ward>((f) => Ward.fromMap(f['properties']))
          .toList();

      final listnominatimplace = featuresnominatimplace
          .where((f) {
            final p = f['properties'];
            if (p == null) return false;

            return (p['category'] == 'amenity' && p['type'] == 'restaurant') ||
                (p['category'] == 'boundary' &&  p['type'] == 'administrative');
          })
          .map<NominatimPlace>((f) => NominatimPlace.fromJson(f))
          .toList();

      final restaurantMap = {for (var r in listrestaurant) r.osmId: r};
      final wardMap = {for (var w in listward) w.osmId: w};

      results = listnominatimplace
          .where((np) =>
              restaurantMap.containsKey(np.osmId) ||
              wardMap.containsKey(np.osmId))
          .toList();
    } catch (e) {
      print(' Lỗi khi search: $e');
      results = [];
    }


    notifyListeners();
  }

  void clear() {
     results = [];
     resultsrestaurnt = [];
     error='';
    notifyListeners();
  }

  
  // FIND BY SEARCH
 
  Future<void> findbysearch(
     TextEditingController searchController,
    MapController mapController, {
    double zoom = 15,
    
  }) async {
    if (results.isEmpty || isLoading ==true) return;

isLoading=true;
 notifyListeners();
    try {
      final boundaryPlaces =
          results.where((e) => e.category == 'boundary').toList();
      final amenityPlaces =
          results.where((e) => e.category == 'amenity').toList();

      final place = boundaryPlaces.length >= amenityPlaces.length
          ? boundaryPlaces.first
          : amenityPlaces.first;

      clear();

      if (place.category == 'boundary') {
          searchController.text =place.displayName;
        final data =
            await _service.getrestaurantIDWARD(int.parse(place.osmId));
        final List featuresrestaurant = data['features'];

        resultsrestaurnt = featuresrestaurant.map((f) => Restaurant.fromFeature(f)).toList();

         final restaurantMap = await addReviewtoRestaurant( resultsrestaurnt, _service);
         resultsrestaurnt= restaurantMap.values.toList();
          
             if(resultsrestaurnt.isEmpty){
         final dataward =await _service.getAddressFromLatLon(place.lat,place.lon);
       error="No restaurant near $dataward";
       isLoading =false;
      notifyListeners();
    return;
         }
      } else {
        for (final amenity in amenityPlaces) {
          final data =
              await _service.getrestaurantID(int.parse(amenity.osmId));
          final List featuresrestaurant = data['features'];

          resultsrestaurnt.addAll(featuresrestaurant.map((f) => Restaurant.fromFeature(f)));
        }
         final restaurantMap = await addReviewtoRestaurant( resultsrestaurnt, _service);
         resultsrestaurnt= restaurantMap.values.toList();
      }

     

      mapController.move(
        LatLng(place.lat, place.lon),
        zoom,
      );
      isLoading=false;
       notifyListeners();
    } catch (e) {
      print(' Lỗi findbysearch: $e');
    
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
    

      if (nominatimplace.category == 'boundary') {
        final data =
            await _service.getrestaurantIDWARD(int.parse(nominatimplace.osmId));
        final List featuresrestaurant = data['features'];

        resultsrestaurnt =
            featuresrestaurant.map((f) => Restaurant.fromFeature(f)).toList();

             final restaurantMap = await addReviewtoRestaurant( resultsrestaurnt, _service);
         resultsrestaurnt= restaurantMap.values.toList();

            if(resultsrestaurnt.isEmpty){
         final dataward =await _service.getAddressFromLatLon(nominatimplace.lat, nominatimplace.lon);
       error="No restaurant near $dataward";
       isLoading =false;
      notifyListeners();
    return;
         }
     
      } else {
        final data =
            await _service.getrestaurantID(int.parse(nominatimplace.osmId));
        final List featuresrestaurant = data['features'];

        resultsrestaurnt =
            featuresrestaurant.map((f) => Restaurant.fromFeature(f)).toList();
             final restaurantMap = await addReviewtoRestaurant( resultsrestaurnt, _service);
         resultsrestaurnt= restaurantMap.values.toList();
      }
  mapController.move(
      LatLng(nominatimplace.lat, nominatimplace.lon),
      zoom,
    );
      isLoading =false;
      notifyListeners();
    } catch (e) {
      print('Lỗi findbypick: $e');
    isLoading =false;
    clear();
    }
  }
Future<void> findbymove(double  minLon,
double minLat,
double maxLon,
double maxLat,
LatLng center,
{TextEditingController? searchController}
) async{
   if ( isLoading ==true) return;
    isLoading =true;
    if(searchController!=null){
searchController.text = '';
    }
    

    clear();
try {
   
   final data =
            await _service.getrestaurantbound(minLon, minLat, maxLon, maxLat);
        final List featuresrestaurant = data['features'];

        resultsrestaurnt =
            featuresrestaurant.map((f) => Restaurant.fromFeature(f)).toList();
             final restaurantMap = await addReviewtoRestaurant( resultsrestaurnt, _service);
         resultsrestaurnt= restaurantMap.values.toList();
           print("số luộng nhà hàng khi move :${resultsrestaurnt.length}");
         if(resultsrestaurnt.isEmpty){
         final dataward =await _service.getAddressFromLatLon(center.latitude, center.longitude);
       error="No restaurant near $dataward";
       isLoading =false;
      notifyListeners();
    return;
         }
     
      isLoading =false;
      notifyListeners();

    } catch (e) {
      print('Lỗi findbypick: $e');
      isLoading =false;
      clear();
    }
}

Future<void> findbyclick(
  double lat, 
  double lon, 

MapController mapController, {
  TextEditingController? searchController,
    double zoom = 15,
  }) async{
    if ( isLoading ==true) return;
try {

      isLoading =true;
      if(searchController!=null){
searchController.text = '';
    }
    
     clear();

      final dataward =await _service.getwardlatlon(lat, lon);

    if (dataward['features']==null) {
       mapController.move(
      LatLng(lat, lon),
      zoom,
    );
    final dataward =await _service.getAddressFromLatLon(lat, lon);
       error="No restaurant near $dataward";
       isLoading =false;
      notifyListeners();
    return;
    }
      final List featuresward = dataward['features'];
      
      final listward = featuresward
          .map<Ward>((f) => Ward.fromMap(f['properties']))
          .toList();
      final place =listward.first;
      final data =   await _service.getrestaurantIDWARD(int.parse(place.osmId));
      final List featuresrestaurant = data['features'];

        resultsrestaurnt =
            featuresrestaurant.map((f) => Restaurant.fromFeature(f)).toList();

       
               final restaurantMap = await addReviewtoRestaurant( resultsrestaurnt, _service);
         resultsrestaurnt= restaurantMap.values.toList();
     print("số luộng nhà hàng khi click1 :${resultsrestaurnt.length}");
 
        mapController.move(
      LatLng(lat, lon),
      zoom,
    );
      isLoading =false;
      notifyListeners();
    } catch (e) {
      print('Lỗi findbypick: $e');
      isLoading =false;
      clear();
    }
}



Future<void> findLocation(MapController mapController,LatLng position,{TextEditingController? searchController}) async {

 try{
 
location = position;

findbyclick(position.latitude, position.longitude, mapController,searchController: searchController);
 }catch(e){

   print('Lỗi findbylocation: $e');
      isLoading =false;
      clear();
 }
}

}
