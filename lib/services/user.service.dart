import 'package:get/get.dart';
import 'package:uda_qlsv/services/app.service.dart';
import 'package:dio/dio.dart';


import '../models/user.dart';
final dio = Dio();
class UserService {
  AppService appService = Get.find<AppService>();


  static Future<String> login(String idsv, String password) async {
    final response = await UserService()
        .appService
        .network
        .post('/users/login', data: {'idsv': idsv, 'password': password});
    return response.data["data"] as String;
  }

  static Future<User> updateUser(
      String idsv, String cccd, String phone, String address) async {
    final res = await UserService().appService.network.patch(
        '/users/update/$idsv',
        data: {'cccd': cccd, 'phone': phone, 'address': address});
    return User.fromJson(res.data['data']);
  }

  static Future<String> forgetPassword(String email) async {
    final response = await dio.post("https://api-qlsv-uda.herokuapp.com/token/", data: {'email' : email});
    return response.data as String;
  }

  static Future<String> resetPassword(String newpw, String token) async {
    final response = await dio.post("https://api-qlsv-uda.herokuapp.com/token/$token", data: {'password' : newpw});
    return response.data as String;
  }
}
