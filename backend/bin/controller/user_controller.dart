import 'dart:convert';



import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import 'package:postgres/postgres.dart';
import  '../models/user_model.dart';

const secretKey = 'your_secret_key';

User? funcdecodeToken(String token) {
  try {
    final jwt = JWT.verify(token, SecretKey(secretKey));
   
     final payload = Map<String, dynamic>.from(jwt.payload);

    return User.fromJson(payload);
  } catch (e) {
  
    print('Token invalid: $e');
    return null;
  }
}
String createToken({required User user}) {


  final jwt = JWT(
    user,
    issuer: 'yourapp',
  );


  final token = jwt.sign(
    SecretKey(secretKey),
    expiresIn: const Duration(days: 30),
  );

  return token;
}

class UserController {
  

     
      final Connection _connection;
      final _headers = {'Content-Type': 'application/json'};


  UserController(this._connection);
  Future<Response> checkphone(Request req) async {

       try {

  final body = jsonDecode(await req.readAsString());
  final phone = body['phone'];
  final sql = '''
SELECT json_agg(
 json_build_object(
 'email',email,
 'phone',phone
 ) )
 AS user
FROM public.user 
WHERE  phone = @phone
''';

  final result = await _connection.execute(Sql.named(sql),
      parameters:  {
        'phone':phone,
        },
    );
   

    print("kq:${result.first.first ?? []}");
     return Response.ok(
      jsonEncode(result.first.first ?? []),
      headers: _headers,
    );

    }catch (e) {
    print("lỗi check phone:$e");
    return Response.internalServerError(
      body: jsonEncode({'error': e.toString()}),
      headers: _headers,
    );
  }
  }
Future<Response> checkemail(Request req) async {
    try {

final body = jsonDecode(await req.readAsString());
final email = body['email'];
final phone = body['phone'];
final sql = (phone == null || phone =="")
    ? '''
      SELECT json_agg(
        json_build_object(
          'email', email,
          'name', name,
          'phone', phone,
          'image', image
        )
      ) AS user
      FROM public.user
      WHERE email = @email
      '''
    : '''
      SELECT json_agg(
        json_build_object(
          'email', email,
          'name', name,
          'phone', phone,
          'image', image
        )
      ) AS user
      FROM public.user
      WHERE email = @email AND phone = @phone
      ''';




 final result = await _connection.execute(Sql.named(sql),
      parameters: (phone ==null || phone=="") ? 
      {
        'email':email,
        }:
          {
        'email':email,
        'phone':phone,
        }
        ,
    );
   




if (result.first.first==null) {
    String token ='';
  return Response.ok(
    jsonEncode({'token': token}),
    headers: _headers,
  );
}else{
  final userDataList = result.first.first as List<dynamic> ;
  String token =createToken(user: User.fromJson(userDataList[0]));
    return Response.ok(
    jsonEncode({'token': token}),
    headers: _headers,
  );
}
    

    }catch (e) {
    print("lỗi check email:$e");
    return Response.internalServerError(
      body: jsonEncode({'error': e.toString()}),
      headers: _headers,
    );
  }
 
  }

Future<Response> decodeToken(Request req) async {

 try {
   final body = jsonDecode(await req.readAsString());
   final token = body['token'];

    final result = funcdecodeToken(token);
    return Response.ok(
      jsonEncode(result?.toJson()),
      headers: _headers,
    );

  } catch (e) {
  
      print('Token invalid: $e');
      return Response.internalServerError(
      body: jsonEncode({'error': e.toString()}),
      headers: _headers,
    );
  }
}

Future<Response> saveUser(Request req) async {

  try {
final body = jsonDecode(await req.readAsString());
final email = body['email'];
final phone = body['phone'];
final lastname = body['lastname'];
final firstname =body['firstname'];
final fullname = '$firstname $lastname';
    final sql = 
      '''
INSERT INTO public.user AS u (email, phone, name)
VALUES (@email, @phone, @name)
RETURNING row_to_json(u) AS user;


''';

    final result = await _connection.execute(
      Sql.named(sql),
      parameters:  {
        'email': email,
        'phone':phone,
        'name':fullname,
        },
    );

   final userDataList = result.first as List<dynamic> ;




if (userDataList.isEmpty) {
    String token ='';
  return Response.ok(
    jsonEncode({'token': token}),
    headers: _headers,
  );
}else{
  String token =createToken(user: User.fromJson(userDataList[0]));
    return Response.ok(
    jsonEncode({'token': token}),
    headers: _headers,
  );
}
  } catch (e) {
     print("lỗi check email:$e");
    return Response.internalServerError(
      body: jsonEncode({'error': e.toString()}),
      headers: _headers,
    );
  }
}
Future<Response> updateUser(Request req) async {
  try {
    final body = jsonDecode(await req.readAsString());
    final oldEmail = body['oldemail'] ?? body['email']; 
    final newEmail = body['email'];
    final phone = body['phone'];
    final lastname = body['lastname'];
    final firstname = body['firstname'];
    final fullname = '$firstname $lastname';


    // 1. Cập nhật user nếu tồn tại
    final updateSql = '''
UPDATE public."user" AS u
SET email = @newEmail,
    phone = @phone,
    name = @name
WHERE email = @oldEmail
RETURNING row_to_json(u) AS user
''';
    final updateResult = await _connection.execute(
      Sql.named(updateSql),
      parameters: {
        'oldEmail': oldEmail,
        'newEmail': newEmail,
        'phone': phone,
        'name': fullname,
      },
    );

    final userDataList = updateResult.first as List<dynamic>;

  if (userDataList.isEmpty) {
    String token ='';
  return Response.ok(
    jsonEncode({'token': token}),
    headers: _headers,
  );
}else{
// print('data ko rõng $userDataList');
  String token =createToken(user: User.fromJson(userDataList[0]));
    return Response.ok(
    jsonEncode({'token': token}),
    headers: _headers,
  );
}
  } catch (e) {
    print("Lỗi saveUser: $e");
    return Response.internalServerError(
      body: jsonEncode({'error': e.toString(),

      }),
      headers: _headers,
    );
  }
}

Future<Response> getUser(Request req) async {
    try {

final email = req.url.queryParameters['email'];
final sql = '''
      SELECT json_agg(
        json_build_object(
          'email', email,
          'name', name,
          'phone', phone,
          'image', image
        )
      ) AS user
      FROM public.user
      WHERE email = @email
      '''
   ;




 final result = await _connection.execute(Sql.named(sql),
      parameters:  {
        'email':email,
        }
    );
   
  return Response.ok(
    jsonEncode(result.first.first ?? []),
    headers: _headers,
  );


    }catch (e) {
    print("lỗi get user:$e");
    return Response.internalServerError(
      body: jsonEncode({'error': e.toString()}),
      headers: _headers,
    );
  }
 
  }
}
