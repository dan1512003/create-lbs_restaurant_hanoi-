import 'package:postgres/postgres.dart';


class PgService {

  static final PgService _instance = PgService._internal();

  static late final Connection _connection;


  PgService._internal();


  factory PgService() {
    return _instance;
  }

 
  static Future<void> connect() async {
 

    try {
         _connection = await Connection.open(
      Endpoint(
        host: 'localhost',
        port: 1513,
        database: 'lbs_hanoi',
        username: 'postgres',
        password: 'leedahee0315',
      ),
      settings: const ConnectionSettings(
    sslMode: SslMode.disable,
  ),
    );
      print('Connected to PostgreSQL!');
    } catch (e) {
      
      print('Error connecting to PostgreSQL: $e');
    
    }
  }


  static Future<void> close() async {
    await _connection.close();
    print('Connection closed');
  }

  static Connection get connection => _connection;
}
