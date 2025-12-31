import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; 
import 'dart:io';

import 'package:restaurant/data/repositories/search_repository.dart';
  String getBackendUrl() {
  if (kIsWeb) {
    return 'http://localhost:3030';
  } else if (Platform.isAndroid) {
    return 'http://10.0.2.2:3030';
  } else {
    return 'http://localhost:3030';
  }
}
class SearchService implements  SearchRepository   {
  static const String baseUrl =
      'https://nominatim.openstreetmap.org/search';

  final _headers = {'Content-Type': 'application/json'};
  @override
  Future<Map<String, dynamic>> searchPlace(String query) async {
    final uri = Uri.parse(baseUrl).replace(queryParameters: {
      'q': query,
      'format': 'geojson',
      'addressdetails': '1',
      'countrycodes': 'vn',
    });

    final response = await http.get(
      uri,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Nominatim API error');
    }
  }

  @override
  Future<String> getAddressFromLatLon(double lat, double lon) async {
  // Tạo URL reverse
  final uri = Uri.https(
    'nominatim.openstreetmap.org',
    '/reverse',
    {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'format': 'jsonv2',
      'addressdetails': '1',
    },
  );

  final response = await http.get(
    uri,
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    
    final displayName = data['display_name'];
    if (displayName != null && displayName is String) {
      return displayName;
    } else {
      return "Không tìm thấy địa chỉ";
    }
  } else {
    return "Lỗi API: ${response.statusCode}";
  }
}
//Kết nối api restauratn
   @override
  Future<Map<String, dynamic>> getrestaurant() async {
  final apirestaurantUrl ='${getBackendUrl()}/api/restaurant';

  final response = await http.get(Uri.parse(apirestaurantUrl));

    if (response.statusCode == 200) {
    final data = jsonDecode(response.body);  
    final innerList = data[0] as List<dynamic>;
    return  innerList[0] as Map<String, dynamic>;
    } else {
      throw Exception('Restaurant API error');
    }
  }


     @override
  Future<Map<String, dynamic>> getrestaurantID(int id) async {
  final apirestaurantUrl = '${getBackendUrl()}/api/restaurantid?osm_id=$id';

  final response = await http.get(Uri.parse(apirestaurantUrl));

    if (response.statusCode == 200) {
    final data = jsonDecode(response.body);  
    final innerList = data[0] as List<dynamic>;
    return  innerList[0] as Map<String, dynamic>;
    } else {
      throw Exception('Restaurant API error');
    }
  }

     @override
  Future<Map<String, dynamic>> getrestaurantIDWARD(int id) async {
  final apirestaurantUrl = '${getBackendUrl()}/api/restaurant?osm_id=$id';

  final response = await http.get(Uri.parse(apirestaurantUrl));

    if (response.statusCode == 200) {
    final data = jsonDecode(response.body);  
    final innerList = data[0] as List<dynamic>;
    return  innerList[0] as Map<String, dynamic>;
    } else {
      throw Exception('Restaurant API error');
    }
  }


     @override
  Future<Map<String, dynamic>> getrestaurantbound(

       double minLon,
       double minLat,
       double maxLon,
       double maxLat
     ) async {
  final url = Uri.parse('${getBackendUrl()}/api/restaurantbound');

    final response = await http.post(
      url,
      headers: _headers,
      body:jsonEncode({
  "minLon": minLon,
  "minLat": minLat,
  "maxLon": maxLon,
  "maxLat": maxLat,
}),

    );

  
     

    if (response.statusCode == 200) {
   
    return jsonDecode(response.body) as Map<String, dynamic> ;
    } else {
      throw Exception('Restaurant API error');
    }
  }


//Kết nối api ward
  @override
  Future<Map<String, dynamic>> getward() async {
  final apiwardUrl ='${getBackendUrl()}/api/ward';

  final response = await http.get(Uri.parse(apiwardUrl));

    if (response.statusCode == 200) {
    final data = jsonDecode(response.body);  
    final innerList = data[0] as List<dynamic>;
    return  innerList[0] as Map<String, dynamic>;
    } else {
      throw Exception('Ward API error');
    }
  }
  @override
  Future<Map<String, dynamic>> getwardID(int id) async {
  final apiwardUrl ='${getBackendUrl()}/api/ward?osm_id=$id';

  final response = await http.get(Uri.parse(apiwardUrl));

    if (response.statusCode == 200) {
    final data = jsonDecode(response.body);  
    final innerList = data[0] as List<dynamic>;
    return  innerList[0] as Map<String, dynamic>;
    } else {
      throw Exception('Ward API error');
    }
  }
  @override
  Future<Map<String, dynamic>> getwardlatlon(double lat,double  lon) async {

final apiwardUrl = '${getBackendUrl()}/api/wardlatlon?lat=$lat&lon=$lon';

  final response = await http.get(Uri.parse(apiwardUrl));

    if (response.statusCode == 200) {
    final data = jsonDecode(response.body);  
  
    final innerList = data[0] as List<dynamic>;
    return  innerList[0] as Map<String, dynamic>;
    } else {
      throw Exception('Ward API error');
    }

  }
//Kêt nối api diet
  @override
  Future<List<dynamic>> getdiet() async {
  final apiwardUrl ='${getBackendUrl()}/api/diet';

  final response = await http.get(Uri.parse(apiwardUrl));

    if (response.statusCode == 200) {
    final data = jsonDecode(response.body);  
   return data as List<dynamic>;
    
    } else {
      throw Exception('Ward API error');
    }
  }

  //Kết nối api review
    @override
  Future<List<dynamic>> getreview() async {
  final apiwardUrl ='${getBackendUrl()}/api/review';

  final response = await http.get(Uri.parse(apiwardUrl));

    if (response.statusCode == 200) {
    final data = jsonDecode(response.body);  
  return  data as List<dynamic>;
     
    } else {
      throw Exception('Ward API error');
    }
  }

@override
  Future<Map<String, dynamic>> addReview({
  required int rateFood,
   required int rateService,
   required  int rateAmbience,
   required int overallRating,
  required String command,
  required String idRestaurant,
  required String email,
  required String date,
}) async {
  final url = Uri.parse('${getBackendUrl()}/api/addreview'); 
  try {
    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode({
        'rateFood': rateFood,
        'rateService': rateService,
        'rateAmbience': rateAmbience,
        'overallRating': overallRating,
        'command': command,
        'idRestaurant': idRestaurant,
        'email': email,
        'date': date, 
      }),
    );

  
    return jsonDecode(response.body) as Map<String, dynamic>;
  } catch (e) {
    // ignore: avoid_print
    print('Error sending request: $e');
    return {};
  }
}



     @override
  Future< List<dynamic>> getreviewID(int id) async {
  final apireviewUrl = '${getBackendUrl()}/api/review?osm_id=$id';

  final response = await http.get(Uri.parse(apireviewUrl));

    if (response.statusCode == 200) {
     return jsonDecode(response.body) as List<dynamic>;

    } else {
      throw Exception('Restaurant API error');
    }
  }

 @override
  Future<List<dynamic>> getReviewEmail(String email) async {
  final apiwardUrl ='${getBackendUrl()}/api/reviewemail?email=$email';

  final response = await http.get(Uri.parse(apiwardUrl));

    if (response.statusCode == 200) {
  
    return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Ward API error');
    }
  }

   @override
  Future<List<dynamic>> getReviewEmailID(String email,int osmId) async {
  final apiwardUrl ='${getBackendUrl()}/api/reviewemail?email=$email&osm_id=$osmId';

  final response = await http.get(Uri.parse(apiwardUrl));

    if (response.statusCode == 200) {
  
    return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Ward API error');
    }
  }


  @override
  Future<Map<String, dynamic>> editReview({
   required int rateFood,
   required int rateService,
   required  int rateAmbience,
   required int overallRating,
  required String command,
  required String idRestaurant,
  required String email,
  required String date,
}) async {
  final url = Uri.parse('${getBackendUrl()}/api/editreview'); 
  try {
    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode({
        'rateFood': rateFood,
        'rateService': rateService,
        'rateAmbience': rateAmbience,
        'overallRating': overallRating,
        'command': command,
        'idRestaurant': idRestaurant,
        'email': email,
        'date': date, 
      }),
    );

  
    return jsonDecode(response.body) as Map<String, dynamic>;
  } catch (e) {
    // ignore: avoid_print
    print('Error sending request: $e');
    return {};
  }
}

//kêt nối api user
  @override
  Future<List<dynamic>> checkPhone(String phone) async {
  final url = Uri.parse('${getBackendUrl()}/api/checkphone');

  try {
    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode({'phone': phone}),
    );

  
      final data = jsonDecode(response.body);

     return data as List<dynamic>;
   
  } catch (e) {
    // ignore: avoid_print
    print('Error sending request: $e');
    return  [];
  }
}

  @override
  Future< Map<String, dynamic>> checkEmail({String phone="",required String email}) async {
  final url = Uri.parse('${getBackendUrl()}/api/checkmail');

  try {
    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode(
        {'phone': phone,
        'email':email
        },
        
        ),
    );

  
     return jsonDecode(response.body) as Map<String, dynamic>;
   
  } catch (e) {
    // ignore: avoid_print
    print('Error sending request: $e');
    return {};
  }
}

  @override
  Future< Map<String, dynamic>> checkToken(String token) async {
  final url = Uri.parse('${getBackendUrl()}/api/checktoken');
  try {
    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode(
        {'token': token,},
        
        ),
    );

  
     return jsonDecode(response.body) ?? {};
   
  } catch (e) {
    // ignore: avoid_print
    print('Error sending request: $e');
    return {};
  }
}


  @override
  Future< Map<String, dynamic>> saveUser(
    String email,
    String phone,
    String lastname, 
    String firstname) async {
  final url = Uri.parse('${getBackendUrl()}/api/saveuser');
  try {
    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode(
        {

        'phone': phone,
        'email':email,
        'lastname': lastname,
        'firstname' :firstname
        },
        
        ),
    );

  
     
     return jsonDecode(response.body) as Map<String, dynamic>;
  } catch (e) {
    // ignore: avoid_print
    print('Error sending request: $e');
    return {};
  }
}

  @override
  Future< Map<String, dynamic>> editUser(
    String email,
    String phone,
    String lastname, 
    String firstname,
    String oldemail
    ) async {
  final url = Uri.parse('${getBackendUrl()}/api/edituser');
  try {
    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode({
        'oldemail': oldemail, 
        'email': email,
        'phone': phone,
        'lastname': lastname,
        'firstname': firstname
      })
    );

  
     
     return jsonDecode(response.body) as Map<String, dynamic>;
  } catch (e) {
    // ignore: avoid_print
    print('Error sending request: $e');
    return {};
  }
}

   @override
  Future< List<dynamic>> getUser(String email) async {
  final apireviewUrl = '${getBackendUrl()}/api/getuser?email=$email';

  final response = await http.get(Uri.parse(apireviewUrl));

    if (response.statusCode == 200) {
     return jsonDecode(response.body) as List<dynamic>;

    } else {
      throw Exception('Restaurant API error');
    }
  }



}
