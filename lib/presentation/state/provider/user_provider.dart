// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:restaurant/data/repositories/localstore_repository.dart';
import 'package:restaurant/data/repositories/search_repository.dart';



import '../../../data/model/user.dart';






class UserProvider extends ChangeNotifier {

    final  SearchRepository  repositoryservice;
   final LocalstoreRepository  localstoreservice;


  UserProvider({required this.repositoryservice,required this.localstoreservice});


  String token ="";
   User? user;
  String phone ="";
  String error="";
 Future<void> checkToken() async {
    
try {
   String? token = await localstoreservice.getToken();
  if(token == null)return;
   final data =await repositoryservice.checkToken(token);
if(data.isNotEmpty){
  user = User.fromJson(data);
  this.token = token;
}else{
  await localstoreservice.deleteToken();
}
 notifyListeners();

    } catch (e) {
      print('Lỗi restaurantdiet: $e');
      notifyListeners();

    }

    }
  
 
 Future<void> checkPhone(String phone) async {
    
try {
 
final data =await repositoryservice.checkPhone(phone);
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
final data =await repositoryservice.checkEmail(email: email,phone: phone) ;
if(data.isEmpty)return;
final token = data['token'] as String? ?? '';

if (token.isNotEmpty) {
final datatoken =await repositoryservice.checkToken(token);
if(datatoken.isNotEmpty){
  user = User.fromJson(datatoken);
  await localstoreservice.saveToken(token);
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
 
final data =await repositoryservice.saveUser(email, phone, lastname, firstname) ;
if(data.isEmpty)return ;
final token = data['token'] as String? ?? '';

if (token.isNotEmpty) {
final datatoken =await repositoryservice.checkToken(token);
if(datatoken.isNotEmpty){
  user = User.fromJson(datatoken);
  await localstoreservice.saveToken(token);
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
    final data = await repositoryservice.editUser(email, phone, lastname, firstname,oldemail);
    
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
      final datatoken = await repositoryservice.checkToken(token);
      if (datatoken.isNotEmpty) {
        user = User.fromJson(datatoken);
        await localstoreservice.deleteToken();
        await localstoreservice.saveToken(token);
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
  await localstoreservice.deleteToken();
  token ="";
    notifyListeners();
  } catch (e) {
    print('Lỗi restaurantdiet: $e');

    notifyListeners();
  }
}

  }


