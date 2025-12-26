// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:restaurant/data/model/diet.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/data/model/review.dart';
import '../../../core/constants/restaurant_utils.dart';

import '../../../data/services/search_service.dart';

import '../../../data/model/ward.dart';


class HomeProvider extends ChangeNotifier {
  final SearchService _service = SearchService();
  
  List<Map<Ward,String>> countrestaurantward= [];


  List<Restaurant> restauranthightrate= [];
  List<Restaurant> restaurantnew= [];
  List<Diet> cuisine =[];
  
    Future<void> restaurantForWard() async {
try {
   

      final dataward = await _service.getward();
      final List featuresward = dataward['features'];
      final listward = featuresward
          .map<Ward>((f) => Ward.fromMap(f['properties']))
          .toList();

for (final ward in listward) {
  final data = await _service.getrestaurantIDWARD(int.parse(ward.osmId));


  if (data['features'] == null) continue;

  final List featuresrestaurant = data['features'];
  int count = featuresrestaurant.length;

  countrestaurantward.add({
    ward: count.toString(),
  });
}


    notifyListeners();

   

      
    } catch (e) {
      print('Lỗi khi search: $e');
      notifyListeners();

    }

    }
//Restaurant hightrate
 Future<void> restaurantHightRate( ) async {
        
try {
   List datareview= await _service.getreview();
   List<Review> review =datareview.map((d)=>Review.fromJson(d)).toList();

    final datarestaurant = await _service.getrestaurant();
    final List featuresrestaurant = datarestaurant['features'];
    List<Restaurant>  restaurantward = featuresrestaurant.map((f) => Restaurant.fromFeature(f)).toList();
   
    
      Map<String, Restaurant> restaurantMap = {for (var r in restaurantward) r.osmId: r};
    for (var r in review) {

     
      if (restaurantMap.containsKey(r.idRestaurant)) {
        final res = restaurantMap[r.idRestaurant]!;
      res.overallRating += r.overallrating ?? 0;
         res.reviewCount += 1;
      }
  }

  List<Restaurant> restaurantHighRate = restaurantMap.values
    .where((r) {
      if (r.reviewCount == 0) return false;
      r.overallRating = r.overallRating / r.reviewCount; 
      return r.overallRating > 2;
    })
    .toList();


restaurantHighRate.sort((a, b) => b.overallRating.compareTo(a.overallRating));


 restauranthightrate = restaurantHighRate.length > 10
    ? restaurantHighRate.sublist(0, 10)
    : restaurantHighRate;
for (var r in restauranthightrate) {
  r.overallRating = 0;
  r.reviewCount = 0;
}

 restaurantMap = await addReviewtoRestaurant(restauranthightrate, _service);
restauranthightrate= restaurantMap.values.toList();

    
    notifyListeners();
      
    } catch (e) {
      print('Lỗi restauranthightrate: $e');
      notifyListeners();

    }

    }


  //Restaurant cuisine
     Future<void> restaurantCuisine() async {
        
try {
   List datadiet= await _service.getdiet();
   List<Diet> diet =datadiet.map((d)=>Diet.fromJson(d)).toList();
   Map<String, Diet> dietMap = {
    for (var d in diet) d.diet.toLowerCase(): d
  };
    final datarestaurant = await _service.getrestaurant();
     final List featuresrestaurant = datarestaurant['features'];
      List<Restaurant>  restaurant = featuresrestaurant.map((f) => Restaurant.fromFeature(f)).toList();
    for (var r in restaurant) {

    Set<String> cuisines = r.cuisine
        .split(';')
        .map((e) => e.trim().toLowerCase())
        .toSet();

    for (var c in cuisines) {
      if (dietMap.containsKey(c)) {
        dietMap[c]!.count += 1;
      }
    }
    cuisine = dietMap.values.toList();
    cuisine = cuisine.where((diet) => diet.count > 0).toList();
  }
    notifyListeners();
      
    } catch (e) {
      print('Lỗi restaurantdiet: $e');
      notifyListeners();

    }

    }


//Restaurant new
 Future<void> restaurantNew() async {
        
try {
  
    final datarestaurant = await _service.getrestaurant();
    final List featuresrestaurant = datarestaurant['features'];
    List<Restaurant>  restaurantward = featuresrestaurant.map((f) => Restaurant.fromFeature(f)).toList();
   
    restaurantnew = restaurantward
    .where((r) => r.starttime != null && isDateInCurrentMonth(r.starttime!))
    .toList();

 final restaurantMap = await addReviewtoRestaurant(restaurantnew, _service);
 restaurantnew= restaurantMap.values.toList();

    notifyListeners();
      
    } catch (e) {
      print(' Lỗi restaurantnew: $e');
      notifyListeners();

    }

    }

  }


