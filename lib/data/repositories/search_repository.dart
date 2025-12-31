abstract class SearchRepository {
  //  Search 
  Future<Map<String, dynamic>> searchPlace(String query);
  Future<String> getAddressFromLatLon(double lat, double lon);

  // Restaurant 
  Future<Map<String, dynamic>> getrestaurant();
  Future<Map<String, dynamic>> getrestaurantID(int id);
  Future<Map<String, dynamic>> getrestaurantIDWARD(int id);
  Future<Map<String, dynamic>> getrestaurantbound(
      double minLon, double minLat, double maxLon, double maxLat);

  // Ward 
  Future<Map<String, dynamic>> getward();
  Future<Map<String, dynamic>> getwardID(int id);
  Future<Map<String, dynamic>> getwardlatlon(double lat, double lon);

  // Diet 
  Future<List<dynamic>> getdiet();

  // Review 
  Future<List<dynamic>> getreview();
  Future<List<dynamic>> getreviewID(int id);
  Future<List<dynamic>> getReviewEmail(String email);
  Future<List<dynamic>> getReviewEmailID(String email, int osmId);
  Future<Map<String, dynamic>> addReview({
    required int rateFood,
    required int rateService,
    required int rateAmbience,
    required int overallRating,
    required String command,
    required String idRestaurant,
    required String email,
    required String date,
  });
  Future<Map<String, dynamic>> editReview({
    required int rateFood,
    required int rateService,
    required int rateAmbience,
    required int overallRating,
    required String command,
    required String idRestaurant,
    required String email,
    required String date,
  });

  // User 
  Future<List<dynamic>> checkPhone(String phone);
  Future<Map<String, dynamic>> checkEmail({String phone, required String email});
  Future<Map<String, dynamic>> checkToken(String token);
  Future<Map<String, dynamic>> saveUser(
      String email, String phone, String lastname, String firstname);
  Future<Map<String, dynamic>> editUser(
      String email, String phone, String lastname, String firstname, String oldemail);
  Future<List<dynamic>> getUser(String email);
}
