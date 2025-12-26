// ignore_for_file: avoid_print

import 'package:flutter/material.dart';



import '../../../data/model/user.dart';
import '../../../data/services/search_service.dart';
import '../../../data/services/localstore_service.dart';




class UserProvider extends ChangeNotifier {
  final SearchService _pgservice = SearchService();
  final LocalstoreService _localstoreService =LocalstoreService();
  String token ="";
   User? user;
  String phone ="";
  String error="";
 Future<void> checkToken() async {
    
try {
   String? token = await _localstoreService.getToken();
  if(token == null)return;
   final data =await _pgservice.checkToken(token);
if(data.isNotEmpty){
  user = User.fromJson(data);
  this.token = token;
}else{
  await _localstoreService.deleteToken();
}
 notifyListeners();

    } catch (e) {
      print('Lỗi restaurantdiet: $e');
      notifyListeners();

    }

    }
  
 
 Future<void> checkPhone(String phone) async {
    
try {
 
final data =await _pgservice.checkPhone(phone);
if(data.isEmpty)return;
 this.phone = data[0]['phone'] as String;
 
 notifyListeners();

    } catch (e) {
      print('Lỗi restaurantdiet: $e');
      notifyListeners();

    }

    }

  Future<void> checkMail(email) async {
    
try {
print("phone $phone");
final data =await _pgservice.checkEmail(email: email,phone: phone) ;
if(data.isEmpty)return;
final token = data['token'] as String? ?? '';

if (token.isNotEmpty) {
final datatoken =await _pgservice.checkToken(token);
if(datatoken.isNotEmpty){
  user = User.fromJson(datatoken);
  await _localstoreService.saveToken(token);
 this.token=token;
  print('Token: $token');

}


} else {

  print('Token rỗng');
}


  notifyListeners();

    } catch (e) {
      print('Lỗi restaurantdiet: $e');
      
       notifyListeners();

    }

    }

  Future<void> saveUser(String phone,String email,String lastname, String firstname) async {
    
try {
 
final data =await _pgservice.saveUser(email, phone, lastname, firstname) ;
if(data.isEmpty)return ;
final token = data['token'] as String? ?? '';

if (token.isNotEmpty) {
final datatoken =await _pgservice.checkToken(token);
if(datatoken.isNotEmpty){
  user = User.fromJson(datatoken);
  await _localstoreService.saveToken(token);
  this.token=token;
  print('Token: $token');
}


} else {

  print('Token rỗng');
}

notifyListeners();
    } catch (e) {
      print('Lỗi restaurantdiet: $e');
   
    }
notifyListeners();
    }
  
Future<void> editUser(String phone, String email, String lastname, String firstname,String oldemail) async {
  try {
    final data = await _pgservice.editUser(email, phone, lastname, firstname,oldemail);
    
    //Kiểm tra xem có lỗi từ backend
    if (data.containsKey('error')) {
      String errorMsg = data['error'] as String? ?? 'Unknown error';
      print('Lỗi saveUser: $errorMsg');

      
      error = errorMsg; 
      notifyListeners();
    return;
    }

//Kiểm tra xem token trả về có đúng ko
    final token = data['token'] as String? ?? '';

    if (token.isNotEmpty) {
      final datatoken = await _pgservice.checkToken(token);
      if (datatoken.isNotEmpty) {
        user = User.fromJson(datatoken);
        await _localstoreService.deleteToken();
        await _localstoreService.saveToken(token);
        this.token = token;
        print('Token: $token');
      }
    } else {
      print('Token rỗng');

    }

    notifyListeners();
  } catch (e) {
    print('Lỗi restaurantdiet: $e');
   error = e.toString();
    notifyListeners();
  }
}

Future<void> signout() async {
  try {
  await _localstoreService.deleteToken();
  token ="";
    notifyListeners();
  } catch (e) {
    print('Lỗi restaurantdiet: $e');

    notifyListeners();
  }
}

  }


