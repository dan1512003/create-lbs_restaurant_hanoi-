import 'dart:convert';
// import 'package:shelf_router/shelf_router.dart';
// import '../models/restaurant_model.dart';
import 'package:shelf/shelf.dart';

import 'package:postgres/postgres.dart';
class WardController {
      final Connection _connection;
      final _headers = {'Content-Type': 'application/json'};


  WardController(this._connection);
Future<Response> getWard(Request request) async {
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
        'name', name,
        'name_en', name_en,
         'image', image
      )
    )
  ), '[]'::json)
) AS geojson
FROM hanoi_basemap.xaphuong_hanoi
'''
        : '''
SELECT json_build_object(
  'type', 'FeatureCollection',
  'features', COALESCE(json_agg(
    json_build_object(
      'type', 'Feature',
      'geometry', ST_AsGeoJSON(geom)::json,
      'properties', json_build_object(
        'full_id', full_id,
        'osm_id', osm_id,
        'name', name,
        'name_en', name_en,
        'image', image
      )
    )
  ), '[]'::json)
) AS geojson
FROM hanoi_basemap.xaphuong_hanoi
WHERE osm_id = @osm_id
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


Future<Response> getWardLatLon(Request request) async {
  try {
final lat = double.tryParse(request.url.queryParameters['lat'] ?? '');
final lon = double.tryParse(request.url.queryParameters['lon'] ?? '');

if (lat == null || lon == null) {
 return Response.badRequest(
        body: jsonEncode({'error': 'lat lon is required'}),
         headers: _headers,
      );
}

   final result = await _connection.execute(
      Sql.named('''
   WITH input_point AS (
    SELECT ST_SetSRID(ST_MakePoint( @lon, @lat), 4326) AS geom
)
SELECT json_build_object(
    'type', 'FeatureCollection',
    'features', COALESCE(json_agg(
        json_build_object(
            'type', 'Feature',
            'geometry', ST_AsGeoJSON(x.geom)::json,
            'properties', json_build_object(
                'full_id', x.full_id,
                'osm_id', x.osm_id,
                'name', x.name,
                'name_en', x.name_en
            )
        )
    )
    )
) AS geojson
FROM hanoi_basemap.xaphuong_hanoi x
JOIN input_point p
ON ST_Contains(x.geom, p.geom);

      '''),
      parameters: {
        'lat': lat,
        'lon':lon
      },
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
}
