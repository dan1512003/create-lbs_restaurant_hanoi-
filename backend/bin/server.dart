import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import './service/pg_service.dart';
import 'routes/restaurant_router.dart';

final _router = Router()
  ..get('/', _rootHandler);


Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}


void main(List<String> args) async {
   await PgService.connect();
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  final corsHeader = createMiddleware(
    requestHandler: (req) {
      if (req.method == "OPTIONS") {
        return Response.ok('', headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET,POST,PUT,DELETE,PATCH,HEAD',
          'Access-Control-Allow-Headers': 'Content-Type,Authorization',
        });
      }
      return null;
    },
    responseHandler: (res) {
      return res.change(headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET,POST,PUT,DELETE,PATCH,HEAD',
        'Access-Control-Allow-Headers': 'Content-Type,Authorization',
      });
    },
  );
final restaurantRouter = RestaurantRouter(PgService.connection);
  _router.mount('/api/', restaurantRouter.router.call);

  // Configure a pipeline that logs requests.
  final handler = Pipeline()
      .addMiddleware(corsHeader)
      .addMiddleware(logRequests())
      .addHandler(_router.call);


  final port = int.parse(Platform.environment['PORT'] ?? '3030');
  final server = await serve(handler, ip, port);
  print('Server đang chạy tại  http://${server.address.host}: ${server.port}');
}
