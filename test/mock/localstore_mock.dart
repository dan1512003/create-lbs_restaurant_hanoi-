import 'package:restaurant/data/repositories/localstore_repository.dart';

class LocalstoreMock implements LocalstoreRepository {


  final List<Map<String, dynamic>> datatoken = [
    {
      "token": "token_alice_123"
    },
  ];

  @override
  Future<void> saveToken(String token) async {
    
      datatoken.add({"token": token});
    
  }

  @override
  Future<String?> getToken() async {
    if (datatoken.isNotEmpty && datatoken[0]['token'] != null) {
      return datatoken[0]['token'] as String?;
    }
    return null;
  }

  @override
  Future<void> deleteToken() async {
    datatoken.clear();
  }
}
