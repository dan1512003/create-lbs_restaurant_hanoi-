// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';


class GeolocatorProvider extends ChangeNotifier {
  

bool locationpermission = false;
 

  
Future<void> getLocationPermission() async {
if(locationpermission ==true)return;
    bool serviceEnabled;
    LocationPermission permission;
 
    // Kiểm tra dịch vụ định vị có được bật không
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return ;
    }
 
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
 
    if (permission == LocationPermission.deniedForever) {
      return ;
    }
locationpermission=true;
notifyListeners();
    return ;
  }
 
  // Lấy vị trí hiện tại
  Future<LatLng?> getCurrentLocation() async {
      if (!locationpermission) {
      await getLocationPermission();
       if (!locationpermission) return null;
      }
 
    try {
     
    
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy:LocationAccuracy.high,
        ),
        
      );
 
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }
 
  // Theo dõi vị trí real-time
  Stream<LatLng> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).map((position) => LatLng(position.latitude, position.longitude));
  }

}
