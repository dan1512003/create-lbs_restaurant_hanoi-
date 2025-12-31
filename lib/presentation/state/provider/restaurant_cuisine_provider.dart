// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/data/repositories/search_repository.dart';
import '../../../core/constants/restaurant_utils.dart';









class RestaurantCuisineProvider extends ChangeNotifier {
  final  SearchRepository  repository;

  RestaurantCuisineProvider({required this.repository});


 List<Restaurant> restaurantcuisine= [];
  


 Future<void> restaurantCuisineoftown(String osmId ,String cuisine) async {
    
try {
     restaurantcuisine= [];
    final datarestaurant = await repository.getrestaurantIDWARD(int.parse(osmId));
     final List featuresrestaurant = datarestaurant['features'];
      List<Restaurant>  restaurant = featuresrestaurant.map((f) => Restaurant.fromFeature(f)).toList();
    for (var r in restaurant) {
    final cuisines = r.cuisine.split(';').map((s) => s.trim()).toList();

  if (cuisines.contains(cuisine)) {
    restaurantcuisine.add(r);
  } 

   final restaurantMap = await addReviewtoRestaurant(restaurantcuisine, repository);
restaurantcuisine= restaurantMap.values.toList();
  }
    notifyListeners();
      
    } catch (e) {
      print('Lỗi restaurantdiet: $e');
      notifyListeners();

    }

    }
  

 Future<void> restaurantCuisineall(String cuisine) async {
        
try {
     restaurantcuisine= [];
    final datarestaurant = await repository.getrestaurant();
     final List featuresrestaurant = datarestaurant['features'];
      List<Restaurant>  restaurant = featuresrestaurant.map((f) => Restaurant.fromFeature(f)).toList();
    for (var r in restaurant) {
    final cuisines = r.cuisine.split(';').map((s) => s.trim()).toList();

  if (cuisines.contains(cuisine)) {
    restaurantcuisine.add(r);
  } 

   final restaurantMap = await addReviewtoRestaurant(restaurantcuisine, repository);
restaurantcuisine= restaurantMap.values.toList();
  }
    notifyListeners();
      
    } catch (e) {
      print('Lỗi restaurantdiet: $e');
      notifyListeners();

    }

    }
  


 
 
  


  }


