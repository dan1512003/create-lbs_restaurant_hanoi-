import 'package:localstore/localstore.dart';

class LocalstoreService {
 
  final _db = Localstore.instance;

  final String _path = 'auth'; 


  Future<void> saveToken(String token) async {
    await _db.collection(_path).doc('token').set({'token': token});
  }


  Future<String?> getToken() async {
    final data = await _db.collection(_path).doc('token').get();
    if (data != null && data.containsKey('token')) {
      return data['token'] as String?;
    }
    return null;
  }


  Future<void> deleteToken() async {
    await _db.collection(_path).doc('token').delete();
  }
}
