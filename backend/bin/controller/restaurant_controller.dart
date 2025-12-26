import 'dart:convert';
// import 'package:shelf_router/shelf_router.dart';
// import '../models/restaurant_model.dart';
import 'package:shelf/shelf.dart';

import 'package:postgres/postgres.dart';
class RestaurantController {
      final Connection _connection;
      final _headers = {'Content-Type': 'application/json'};

  // Constructor nhận connection
  RestaurantController(this._connection);
 
Future<Response> getRestaurants(Request request) async {
  try {
    final osmId = request.url.queryParameters['osm_id'];

    final sql = osmId == null
        ? '''
SELECT json_build_object(
  'type', 'FeatureCollection',
  'features', COALESCE(json_agg(
    json_build_object(
      'type', 'Feature',
      'geometry', ST_AsGeoJSON(geom)::json,
      'properties', json_build_object(
        'full_id', full_id,
        'osm_id', osm_id,
        'price', price,
        'kids_area', kids_area,
        'baby_feeding', baby_feeding,
        'self_service', self_service,
        'website_me', website_me,
        'image', image,
        'bar', bar,
        'indoor', indoor,
        'contact_in', contact_in,
        'air_conditioning', air_conditioning,
        'outdoor', outdoor,
        'email', email,
        'contact_fa', contact_fa,
        'delivery', delivery,
        'description', description,
        'phone', phone,
        'opening_hour', opening_hour,
        'cuisine', cuisine,
        'website', website,
        'addr_street', addr_street,
        'name', name,
        'payment', payment,
        'diet', diet,
        'starttime', starttime
      )
    )
  )
  )
) AS geojson
FROM hanoi_thematic.bando_chuyende_nhahang_hanoi
'''
        : '''
SELECT json_build_object(
  'type', 'FeatureCollection',
  'features', COALESCE(json_agg(
    json_build_object(
      'type', 'Feature',
      'geometry', ST_AsGeoJSON(n.geom)::json,
      'properties', json_build_object(
        'full_id', n.full_id,
        'osm_id', n.osm_id,
        'price', n.price,
        'kids_area', n.kids_area,
        'baby_feeding', n.baby_feeding,
        'self_service', n.self_service,
        'website_me', n.website_me,
        'image', n.image,
        'bar', n.bar,
        'indoor', n.indoor,
        'contact_in', n.contact_in,
        'air_conditioning', n.air_conditioning,
        'outdoor', n.outdoor,
        'email', n.email,
        'contact_fa', n.contact_fa,
        'delivery', n.delivery,
        'description', n.description,
        'phone', n.phone,
        'opening_hour', n.opening_hour,
        'cuisine', n.cuisine,
        'website', n.website,
        'addr_street', n.addr_street,
        'name', n.name,
        'payment', n.payment,
        'diet', n.diet,
        'starttime',n.starttime
      )
    )
  )
  )
) AS geojson
FROM hanoi_thematic.bando_chuyende_nhahang_hanoi n
JOIN hanoi_basemap.xaphuong_hanoi x
  ON ST_Within(n.geom, x.geom)
WHERE x.osm_id = @osm_id
''';

    final result = await _connection.execute(
      Sql.named(sql),
      parameters: osmId == null ? null : {'osm_id': osmId},
    );

    return Response.ok(
      jsonEncode(result),
      headers: _headers,
    );
  } catch (e) {
    return Response.internalServerError(
      body: jsonEncode({'error': e.toString()}),
      headers: _headers,
    );
  }
}
Future<Response> getRestaurantsID(Request request) async {
  
 final osmid = request.url.queryParameters['osm_id'];

    if (osmid == null) {
      return Response.badRequest(
        body: jsonEncode({'error': 'osm_id is required'}),
         headers: _headers,
      );
    }

    final result = await _connection.execute(
      Sql.named('''
    SELECT json_build_object(
  'type', 'FeatureCollection',
  'features', COALESCE(json_agg(
    json_build_object(
      'type', 'Feature',
      'geometry', ST_AsGeoJSON(geom)::json,
      'properties', json_build_object(
        'full_id', full_id,
        'osm_id', osm_id,
        'price', price,
        'kids_area', kids_area,
        'baby_feeding', baby_feeding,
        'self_service', self_service,
        'website_me', website_me,
        'image', image,
        'bar', bar,
        'indoor', indoor,
        'contact_in', contact_in,
        'air_conditioning', air_conditioning,
        'outdoor', outdoor,
        'email', email,
        'contact_fa', contact_fa,
        'delivery', delivery,
        'description', description,
        'phone', phone,
        'opening_hour', opening_hour,
        'cuisine', cuisine,
        'website', website,
        'addr_street', addr_street,
        'name', name,
        'payment', payment,
        'diet', diet,
        'starttime', starttime
      )
    )
  )
  )
) AS geojson
FROM hanoi_thematic.bando_chuyende_nhahang_hanoi
WHERE osm_id = @osm_id
      '''),
      parameters: {
        'osm_id': osmid,
      },
    );

    return Response.ok(
      jsonEncode(result),
      headers: _headers,
    );

}


Future<Response> getRestaurantsbound(Request request) async {
  
 final body = jsonDecode(await request.readAsString());
   final minLon = (body['minLon'] as num).toDouble();
final minLat = (body['minLat'] as num).toDouble();
final maxLon = (body['maxLon'] as num).toDouble();
final maxLat = (body['maxLat'] as num).toDouble();
   



    final result = await _connection.execute(
      Sql.named('''
WITH bounds AS (
  SELECT ST_MakeEnvelope(
    @minLon,  
    @minLat,   
    @maxLon,   
    @maxLat,  
           4326
         ) AS geom_bbox
)
SELECT json_build_object(
  'type', 'FeatureCollection',
  'features', COALESCE(json_agg(
    json_build_object(
      'type', 'Feature',
      'geometry', ST_AsGeoJSON(n.geom)::json,
      'properties', json_build_object(
        'full_id', n.full_id,
        'osm_id', n.osm_id,
        'price', n.price,
        'kids_area', n.kids_area,
        'baby_feeding', n.baby_feeding,
        'self_service', n.self_service,
        'website_me', n.website_me,
        'image', n.image,
        'bar', n.bar,
        'indoor', n.indoor,
        'contact_in', n.contact_in,
        'air_conditioning', n.air_conditioning,
        'outdoor', n.outdoor,
        'email', n.email,
        'contact_fa', n.contact_fa,
        'delivery', n.delivery,
        'description', n.description,
        'phone', n.phone,
        'opening_hour', n.opening_hour,
        'cuisine', n.cuisine,
        'website', n.website,
        'addr_street', n.addr_street,
        'name', n.name,
        'payment', n.payment,
        'diet', n.diet,
        'starttime', n.starttime
      )
    )
  ), '[]'::json)
) AS geojson
FROM hanoi_thematic.bando_chuyende_nhahang_hanoi n
JOIN bounds b
  ON ST_Within(n.geom, b.geom_bbox)

      '''),
      parameters: {
        'minLon': minLon,
        'minLat': minLat,
        'maxLon': maxLon,
        'maxLat': maxLat,
      },
    );

    return Response.ok(
      jsonEncode(result.first.first),
      headers: _headers,
    );

}
}
