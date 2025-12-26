import 'dart:convert';
// import 'package:shelf_router/shelf_router.dart';
// import '../models/restaurant_model.dart';
import 'package:shelf/shelf.dart';

import 'package:postgres/postgres.dart';
class ReviewController {
      final Connection _connection;
      final _headers = {'Content-Type': 'application/json'};


  ReviewController(this._connection);
Future<Response> getReview(Request request) async {
  try {
final osmId = request.url.queryParameters['osm_id'];

    final sql = osmId == null?
    '''
SELECT json_agg(
 json_build_object(
           'id', id,
           'ratefood', ratefood,
           'rateservice', rateservice,
           'rateambience', rateambience,
           'overallrating', overallrating,
           'command', command,
           'id_restaurant', id_restaurant,
           'email', email,
           'date', date,
           'like', "like"
         ) )AS reviews
FROM public.review



''':'''
SELECT json_agg(
 json_build_object(
           'id', id,
           'ratefood', ratefood,
           'rateservice', rateservice,
           'rateambience', rateambience,
           'overallrating', overallrating,
           'command', command,
           'id_restaurant', id_restaurant,
           'email', email,
           'date', date,
           'like', "like"
         ) )AS reviews
FROM public.review r
WHERE r.id_restaurant = @osm_id

''' ;

    final result = await _connection.execute(
      Sql.named(sql),
      parameters: osmId == null ? null : {'osm_id': osmId},
      );

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

Future<Response> addReview(Request request) async {
  try {

final body = jsonDecode(await request.readAsString());
    final rateFood = body['rateFood']; 
    final rateService = body['rateService'];
    final rateAmbience = body['rateAmbience'];
    final overallRating = body['overallRating'];
    final command = body['command'];
    final idRestaurant = body['idRestaurant'];
    final email = body['email'];
    final date = body['date'];
   

    final sql = 
    '''
INSERT INTO public.review (
    id_restaurant,
    email,
    ratefood,
    rateservice,
    rateambience,
    overallrating,
    command,
    date
) VALUES (
    @idRestaurant,
    @email,
    @rateFood,
    @rateService,
    @rateAmbience,
    @overallRating,
    @command,
    @date
)
''';

    await _connection.execute(
      Sql.named(sql),
      parameters:  {
        'idRestaurant': idRestaurant,
        'email': email,
        'rateFood': rateFood,
        'rateAmbience': rateAmbience,
        'rateService': rateService,
        'overallRating': overallRating,
        'command': command,
        'date':date
      },
      );

    return Response.ok(
      jsonEncode( {'resutl':"them thanh cong"}),
      headers: _headers,
    );
  } catch (e) {
    return Response.internalServerError(
      body: jsonEncode({'error': e.toString()}),
      headers: _headers,
    );
  }
}

Future<Response> getReviewEmail(Request request) async {
  try {
final email = request.url.queryParameters['email'];

final osmId = request.url.queryParameters['osm_id'];

    final sql = osmId == null?
    '''
SELECT json_agg(
 json_build_object(
           'id', id,
           'ratefood', ratefood,
           'rateservice', rateservice,
           'rateambience', rateambience,
           'overallrating', overallrating,
           'command', command,
           'id_restaurant', id_restaurant,
           'email', email,
           'date', date,
           'like', "like"
         ) )AS reviews
FROM public.review r
WHERE  r.email =@email



''':'''
SELECT json_agg(
 json_build_object(
           'id', id,
           'ratefood', ratefood,
           'rateservice', rateservice,
           'rateambience', rateambience,
           'overallrating', overallrating,
           'command', command,
           'id_restaurant', id_restaurant,
           'email', email,
           'date', date,
           'like', "like"
         ) )AS reviews
FROM public.review r
WHERE r.id_restaurant = @osm_id AND r.email =@email

''' ;

    final result = await _connection.execute(
      Sql.named(sql),
      parameters: osmId == null ?  {'email': email}: {'email': email,'osm_id': osmId},
      );

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

Future<Response> editReview(Request request) async {
  try {
    final body = jsonDecode(await request.readAsString());

    final idRestaurant = body['idRestaurant'];
    final email = body['email'];
    final rateFood = body['rateFood'];
    final rateService = body['rateService'];
    final rateAmbience = body['rateAmbience'];
    final overallRating = body['overallRating'];
    final command = body['command'];
    final date = body['date'];

 

    final sql = '''
UPDATE public.review
SET
    ratefood = @rateFood,
    rateservice = @rateService,
    rateambience = @rateAmbience,
    overallrating = @overallRating,
    command = @command,
    date = @date
WHERE id_restaurant = @idRestaurant AND email = @email
''';

   await _connection.execute(
      Sql.named(sql),
      parameters: {
        'idRestaurant': idRestaurant,
        'email': email,
        'rateFood': rateFood,
        'rateService': rateService,
        'rateAmbience': rateAmbience,
        'overallRating': overallRating,
        'command': command,
        'date': date,
      },
    );

    return Response.ok(
      jsonEncode({'result': 'cap nhat thanh cong'}),
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
