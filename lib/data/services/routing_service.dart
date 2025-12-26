// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
 
class RoutingService {
  static const String _osrmBaseUrl = 'https://router.project-osrm.org';
 
  // Tính toán tuyến đường giữa hai điểm
  Future<RouteResult?> getRoute(LatLng start, LatLng end) async {
    try {
      final url = Uri.parse(
        '$_osrmBaseUrl/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson&steps=true',
      );
 
      final response = await http.get(url);
 
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
 
        if (data['code'] == 'Ok' &&
            data['routes'] != null &&
            data['routes'].isNotEmpty) {
          return RouteResult.fromJson(data['routes'][0]);
        }
      }
      return null;
    } catch (e) {
      print('Routing error: $e');
      return null;
    }
  }
 

}
 
class RouteResult {
  final List<LatLng> points;
  final double distance; 
  final double duration; 
  final List<RouteStep> steps;
 
  RouteResult({
    required this.points,
    required this.distance,
    required this.duration,
    required this.steps,
  });
 
  factory RouteResult.fromJson(Map<String, dynamic> json) {
    final geometry = json['geometry'];
    List<LatLng> points = [];
 
    if (geometry != null && geometry['coordinates'] != null) {
      points = (geometry['coordinates'] as List).map((coord) {
        return LatLng(coord[1].toDouble(), coord[0].toDouble());
      }).toList();
    }
 
    List<RouteStep> steps = [];
    if (json['legs'] != null && json['legs'].isNotEmpty) {
      final leg = json['legs'][0];
      if (leg['steps'] != null) {
        steps = (leg['steps'] as List)
            .map((step) => RouteStep.fromJson(step))
            .toList();
      }
    }
 
    return RouteResult(
      points: points,
      distance: json['distance']?.toDouble() ?? 0.0,
      duration: json['duration']?.toDouble() ?? 0.0,
      steps: steps,
    );
  }
 

 //hàm lấy khoảng cách
  String get distanceText {
    if (distance < 1000) {
      return '${distance.toStringAsFixed(0)} m';
    }
    return '${(distance / 1000).toStringAsFixed(2)} km';
  }
 
 //hàm  thòi gian trong suốt
  String get durationText {
    final minutes = (duration / 60).round();
    if (minutes < 60) {
      return '$minutes phút';
    }
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return '$hours giờ $mins phút';
  }
}
 

class RouteStep {
  final String instruction;
  final double distance;
  final double duration;
  final String? name;
  final String type;
  final String modifier;

  RouteStep({
    required this.instruction,
    required this.distance,
    required this.duration,
    this.name,
    this.type = '',
    this.modifier = '',
  });

  factory RouteStep.fromJson(Map<String, dynamic> json) {
    final maneuver = json['maneuver'] ?? {};
    final type = maneuver['type'] ?? '';
    final modifier = maneuver['modifier'] ?? '';

    String instruction;

    if (type == 'depart') {
      instruction = 'Start';
    } else if (type == 'arrive') {
      instruction = 'Arrive';
    } else if (type == 'turn' || type == 'continue') {
      switch (modifier) {
        case 'right':
          instruction = 'Turn right';
          break;
        case 'left':
          instruction = 'Turn left';
          break;
        case 'slight right':
          instruction = 'Slight right';
          break;
        case 'slight left':
          instruction = 'Slight left';
          break;
        case 'sharp right':
          instruction = 'Sharp right';
          break;
        case 'sharp left':
          instruction = 'Sharp left';
          break;
        default:
          instruction = 'Go straight';
      }
    } else if (type == 'roundabout') {
      instruction = 'Enter roundabout';
    } else if (type == 'merge') {
      instruction = 'Merge';
    } else if (type == 'on ramp') {
      instruction = 'Enter highway';
    } else if (type == 'off ramp') {
      instruction = 'Exit highway';
    } else if (type == 'fork') {
      instruction = 'Take fork';
    } else if (type == 'end of road') {
      instruction = 'End of road';
    } else {
      instruction = type; 
    }

    return RouteStep(
      instruction: instruction,
      distance: json['distance']?.toDouble() ?? 0.0,
      duration: json['duration']?.toDouble() ?? 0.0,
      name: json['name'],
      type: type,
      modifier: modifier,
    );
  }

  // Distance text
  String get distanceText {
    if (distance < 1000) {
      return '${distance.toStringAsFixed(0)} m';
    }
    return '${(distance / 1000).toStringAsFixed(2)} km';
  }

  // Duration text
  String get durationText {
    final minutes = (duration / 60).round();
    if (minutes < 60) {
      return '$minutes min';
    }
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return '$hours h $mins min';
  }
}
