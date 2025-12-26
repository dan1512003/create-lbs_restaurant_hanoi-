// import 'dart:convert';
// import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:postgres/postgres.dart';
import '../controller/restaurant_controller.dart';
import '../controller/ward_controller.dart';
import '../controller/diet_controller.dart';
import '../controller/review_controller.dart';
import '../controller/user_controller.dart';
class RestaurantRouter {
 
  final Connection _connection;
  late final RestaurantController _restaurantController;
  late final WardController _wardController;
  late final DietController _dietController;
  late final UserController _userController;
  late final ReviewController _reviewController;
  RestaurantRouter(this._connection){
     _restaurantController = RestaurantController(_connection);
     _wardController=WardController(_connection);
     _reviewController=ReviewController(_connection);
     _dietController=DietController(_connection);
     _userController=UserController(_connection);
     

  }
  
  Router get router {
    final router = Router();
    router.get('/restaurant', _restaurantController.getRestaurants);
    router.get('/restaurantid',_restaurantController.getRestaurantsID);
    router.post('/restaurantbound',_restaurantController.getRestaurantsbound);
    router.get('/ward',_wardController.getWard);
    router.get('/wardlatlon',_wardController.getWardLatLon);
    router.get('/diet', _dietController.getDiet);
    router.get('/review', _reviewController.getReview);
    router.get('/reviewemail', _reviewController.getReviewEmail);
    router.post('/addreview', _reviewController.addReview);
    router.post('/editreview', _reviewController.editReview);
     router.get('/getuser', _userController.getUser);
    router.post('/checkmail', _userController.checkemail);
    router.post('/checkphone', _userController.checkphone);
    router.post('/saveuser', _userController.saveUser);
     router.post('/edituser', _userController.updateUser);
    router.post('/checktoken', _userController.decodeToken);
    return router;
  }

 
}