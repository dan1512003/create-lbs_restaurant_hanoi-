import 'package:localstore/localstore.dart';
import 'package:restaurant/data/repositories/localstore_repository.dart';

class LocalstoreService implements LocalstoreRepository {
 
  final _db = Localstore.instance;

  final String _path = 'auth'; 


  @override
  Future<void> saveToken(String token) async {
    await _db.collection(_path).doc('token').set({'token': token});
  }


  @override
  Future<String?> getToken() async {
    final data = await _db.collection(_path).doc('token').get();
    if (data != null && data.containsKey('token')) {
      return data['token'] as String?;
    }
    return null;
  }


  @override
  Future<void> deleteToken() async {
    await _db.collection(_path).doc('token').delete();
  }
}
