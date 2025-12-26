// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:restaurant/data/model/review.dart';
import 'package:restaurant/data/model/user.dart';
import '../../../data/services/search_service.dart';





class RestaurantProvider extends ChangeNotifier {
  final SearchService _pgservice = SearchService();
 Map<int, int> starCount = {
  1: 0,
  2: 0,
  3: 0,
  4: 0,
  5: 0,
};
 List<Review> review =[];
List<Review> command=[];
 Future<String> getAddress(double lat, double lon) async {
    
try {
   return await _pgservice.getAddressFromLatLon(lat, lon);
 
    } catch (e) {
      print('Lỗi getAddress(: $e');
      return'';
      
    }

    }
  Future<User?> getUser(String email) async {
    
try {
  final datauser =await _pgservice.getUser(email);
  final data =datauser.first as Map<String,dynamic>;
   return User.fromJson(data);
 
    } catch (e) {
      print('Lỗi getAddress(: $e');
      return null;
      
    }

    }
  
 
 Future<void> getReview(String osmId) async {
    
try {
 starCount = {
  1: 0,
  2: 0,
  3: 0,
  4: 0,
  5: 0,
};
 final datareview = await _pgservice.getreviewID(int.parse(osmId));
    
 review = datareview
          .map<Review>((f) => Review.fromJson(f))
          .toList();
 command = datareview
    .map<Review>((f) => Review.fromJson(f))
    .where((r) => r.command != null && r.command!.trim().isNotEmpty)
    .toList();

 for (var r in review) {
  if (r.overallrating != null) {
    int star = r.overallrating!; 
    if (star >= 1 && star <= 5) {
      starCount[star] = starCount[star]! + 1;
    }
  }
}
 notifyListeners();

    } catch (e) {
      print('Lỗi getReview: $e');
      notifyListeners();

    }

    }

 
 Future<List<Review>> getReviewEmail(String email) async {
    
try {
 
 final datareview = await _pgservice.getReviewEmail(email);
    
return review = datareview
          .map<Review>((f) => Review.fromJson(f))
          .toList();
 
 

    } catch (e) {
      print('Lỗi restaurantdiet: $e');
     return[];

    }

    }
Future<List<Review>> getReviewEmailID(String email,String osmId) async {
    
try {
 
 final datareview = await _pgservice.getReviewEmailID(email, int.parse(osmId));
    
return review = datareview
          .map<Review>((f) => Review.fromJson(f))
          .toList();
 
 

    } catch (e) {
      print('Lỗi getReviewEmailID: $e');
     return[];

    }

    }
Future<void> addReview(
 {
  int rateFood=0,
  int rateService=0,
  int rateAmbience=0,
  int overallRating=0,
  String command="",
  required String idRestaurant,
  required String email,
  required String date,
}
) async {
    
try {
 
 await _pgservice.addReview(
  idRestaurant: idRestaurant, 
  email: email, 
  date: date,
  rateFood: rateFood,
  rateAmbience: rateAmbience,
  rateService: rateService,
  overallRating: overallRating,
  command: command
  );
    
getReview(idRestaurant);
 print("add thanh cong");


    } catch (e) {
      print('Lỗi add review: $e');
    

    }

    }


Future<void> editReview(
{
  required int rateFood,
   required int rateService,
   required  int rateAmbience,
   required int overallRating,
  required String command,
  required String idRestaurant,
  required String email,
  required String date,
}
) async {
    
try {
 
 await _pgservice.editReview(
  idRestaurant: idRestaurant, 
  email: email, 
  date: date,
  rateFood: rateFood,
  rateAmbience: rateAmbience,
  rateService: rateService,
  overallRating: overallRating,
  command: command
  );
    
getReview(idRestaurant);
 print("udate thanh cong");
 

    } catch (e) {
      print('Lỗi udate review: $e');
    

    }

    }

  }


