import 'dart:convert';
// import 'package:shelf_router/shelf_router.dart';
// import '../models/restaurant_model.dart';
import 'package:shelf/shelf.dart';

import 'package:postgres/postgres.dart';
class DietController {
      final Connection _connection;
      final _headers = {'Content-Type': 'application/json'};


  DietController(this._connection);
Future<Response> getDiet(Request request) async {
  try {


final sql = '''
SELECT json_agg(
  json_build_object(
    'id', id,
    'diet', diet,
    'image', image
  )
) AS diets
FROM public.diet;
''';

final result = await _connection.execute(Sql.named(sql));



return Response.ok(
  jsonEncode( result.first.first ?? []), 
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
