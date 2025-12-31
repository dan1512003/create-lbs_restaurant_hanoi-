abstract class LocalstoreRepository {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}