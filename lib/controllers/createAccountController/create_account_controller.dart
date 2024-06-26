import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/create_account_model.dart';
import '../../routes/app_routes.dart';
import '../../services/api_checker.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';
import '../authController/auth_controller.dart';

class CreateAccountController extends GetxController {
  var loading = false.obs;
  Rx<CreateAccountModel> createAccountModel = CreateAccountModel().obs;

  ///======================update profile============================>
  createProfile(String name, password, phoneNumber, File? image) async {
    final AuthController authController = Get.find<AuthController>();

    List<MultipartBody> multipartBody =
        image == null ? [] : [MultipartBody("image", image)];

    Map<String, String> body = {
      "name": name,
      "password": password,
      "phone": authController.selectedCountryCode +
          authController.phoneNumberCTRl.text,
    };

    debugPrint(
        "================$name, $password, $phoneNumber, ${image?.path}");

    var response = await ApiClient.postMultipartData(
      ApiConstants.updateProfileEndPoint,
      body,
      multipartBody: multipartBody,
    );

    print(
        "===========response body : ${response.body} \nand status code : ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {

      Get.offAllNamed(AppRoutes.logInScreen);
      createAccountModel.value = CreateAccountModel.fromJson(
          json.decode(response.body)['data']['attributes']);
      createAccountModel.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
