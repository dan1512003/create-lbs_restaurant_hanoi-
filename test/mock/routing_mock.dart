

// ignore_for_file: avoid_print

import 'package:latlong2/latlong.dart';
import 'package:restaurant/data/services/routing_service.dart';

class RoutingMock implements RoutingRepository {

  @override
  Future<RouteResult?> getRoute(LatLng start, LatLng end) async {
    try {
 

   
      final points = <LatLng>[
        
      ];

      // Mock steps
      final steps = <RouteStep>[
        RouteStep(
          instruction: 'Start',
          distance: 0,
          duration: 0,
          name: null,
          type: 'depart',
        ),
        RouteStep(
          instruction: 'Go straight',
          distance: 500,
          duration: 300,
          name: 'Mock Road',
          type: 'continue',
        ),
        RouteStep(
          instruction: 'Arrive',
          distance: 0,
          duration: 0,
          name: null,
          type: 'arrive',
        ),
      ];

     
      const distance = 1200.0; 
      const duration = 600.0; 

      return RouteResult(
        points: points,
        distance: distance,
        duration: duration,
        steps: steps,
      );
    } catch (e) {
      print('Routing mock error: $e');
      return null;
    }
  }
}
