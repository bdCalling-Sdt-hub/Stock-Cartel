import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/profile_model.dart';
import '../../routes/app_routes.dart';
import '../../services/api_checker.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';
import '../authController/auth_controller.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  ///======================update profile============================>

  createProfile(String name, password, phoneNumber, File? image) async {

    List<MultipartBody> multipartBody =
    image == null ? [] : [MultipartBody("image", image)];
    Map<String, String> body = {
      "name": name,
      "password": password,
      "phone":  '+8801610663268',
    };

    debugPrint("================$name, $password, $phoneNumber, ${image!.path}");

    var response = await ApiClient.postMultipartData(
      ApiConstants.updateProfileEndPoint,
      body,
      multipartBody: multipartBody,
    );
    print("===========response body : ${response.body} \nand status code : ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      profileModel.value = ProfileModel.fromJson(response.body['data']['attributes']);
      profileModel.refresh();
      Get.offAllNamed(AppRoutes.logInScreen);
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
