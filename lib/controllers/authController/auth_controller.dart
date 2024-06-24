import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../helpers/prefs_helpers.dart';
import '../../routes/app_routes.dart';
import '../../services/api_checker.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';
import '../../utils/app_constants.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final phoneNumberCTRl = TextEditingController();
  var registerLoading = false.obs;
  var token = "";
  String selectedCountryCode = '+880';

  Future<void> handleRegister() async {
    registerLoading(true);
    try {
      String phoneNumber = phoneNumberCTRl.text.trim();
      String countryCode = selectedCountryCode;
      Map<String, dynamic> body = {
        "phone": countryCode + phoneNumber,
      };
      print("===================> Request Body: $body");

      var headers = {'Content-Type': 'application/json'};
      Response response = await ApiClient.postData(
        ApiConstants.registerEndPoint,
        jsonEncode(body),
        headers: headers,
      );
      print("============> Response: ${response.body} and Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        Get.toNamed(AppRoutes.verifyNumberScreen, parameters: {
          "phone": phoneNumber,
          "screenType": "registerScreen",
        });
        var responseBody = json.decode(response.body);
        Fluttertoast.showToast(msg: responseBody['message']);
        phoneNumberCTRl.clear();
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e, s) {
      print("===> Error: $e");
      print("===> Stack Trace: $s");
    } finally {
      registerLoading(false);
    }
  }


  //============================================>  Log in <==============================
  TextEditingController logInPassCtrl = TextEditingController();
  TextEditingController logInPhoneNumberCtrl = TextEditingController();
  String selectedCountryCodes = '+880';
  var logInLoading = false.obs;

  Future<void> handleLogIn() async {
    logInLoading(true);
    var headers = {
      'Content-Type': 'application/json'
    };
    String phoneNumber = logInPhoneNumberCtrl.text.trim();
    String password = logInPassCtrl.text.trim();
    String countryCode = selectedCountryCodes;
    Map<String, dynamic> body = {
      'phone': countryCode + phoneNumber,
      'password': password
    };
    Response response = await ApiClient.postData(
        ApiConstants.loginEndPoint, json.encode(body),
        headers: headers);
    print("====> ${response.body}");
    print("============> Response: ${response.body} and Status Code: ${response.statusCode}");

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.homeScreen);
      var responseBody = response.body;
      await PrefsHelper.setString(AppConstants.bearerToken, responseBody['data']['token']);
      await PrefsHelper.setBool(AppConstants.isLogged, true);
      await PrefsHelper.setString(AppConstants.id, responseBody['data']['attributes']['_id']);
      logInPhoneNumberCtrl.clear();
      logInPassCtrl.clear();
    } else {
      Fluttertoast.showToast(msg: response.statusText ?? "Login failed");
    }
    logInLoading.value = false;
  }


  //======================================> Resend otp <======================================
  var resendOtpLoading = false.obs;

  resendOtp(String phone) async {
    resendOtpLoading(true);
    var body = {"phone": phone};
    Map<String, String> header = {'Accept-Language': 'en',};
    var response = await ApiClient.postData(
        ApiConstants.otpVerifyEndPoint, json.encode(body),
        headers: header);
    print("===> ${response.body}");
    if (response.statusCode == 200) {

    } else {
      Fluttertoast.showToast(
          msg: response.statusText ?? "",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER);
    }
    resendOtpLoading(false);
  }


  //=====================================> Otp very <====================================
  TextEditingController otpCtrl = TextEditingController();
  var verifyLoading = false.obs;

  Future<void> handleOtpVery({
    required String phone,
    required String otp,
    required String type,
  }) async {
    var headers = {
      'Accept-Language': 'en',
      'Content-Type': 'application/json',
      'Cookie': 'i18next=en'
    };

    try {
      var body = {'phone': phone, 'otpCode': otp};
      verifyLoading(true);
      Response response = await ApiClient.postData(
        ApiConstants.otpVerifyEndPoint,
        jsonEncode(body),
        headers: headers,
      );

      print("===========.> $response");
      print("============${response.body} and ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (type == "forgotPasswordScreen") {
          Get.toNamed(
              AppRoutes.setNewPasswordScreen, parameters: {"phone": phone});
        } else {
          Get.offAllNamed(AppRoutes.createAccountScreen);
        }
        var responseBody = json.decode(response.body);
        await PrefsHelper.setString(
            AppConstants.bearerToken, responseBody["data"]['token']);
        await PrefsHelper.setString(AppConstants.id, responseBody['data']['attributes']['_id']);
        print('================token ${responseBody["data"]['token']}');

      } else {
        ApiChecker.checkApi(response);
      }
      otpCtrl.clear();
    } catch (e, s) {
      print("===> e : $e");
      print("===> s : $s");
    } finally {
      verifyLoading(false);
    }
  }

//=================================> Forgot pass word <==========================================
  var forgotLoading = false.obs;

  forgotPassword(String phone) async {
    forgotLoading(true);
    var body = {"phone": phone};
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.forgetPasswordEndPoint, json.encode(body),
        headers: header);
    if (response.statusCode == 200) {
      Get.toNamed(AppRoutes.verifyNumberScreen,
          parameters: {"phone": phone, "screenType": "forgot"});
    } else {
      Fluttertoast.showToast(msg: response.statusText ?? "");
    }
    forgotLoading(false);
  }

 //====================================> Reset password <==================================
 var setPasswordLoading = false.obs;
  setPassword(String phone, String password) async {
    setPasswordLoading(true);
    var body = {"phone": phone, "password": password};
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.setPasswordEndPoint, json.encode(body),
        headers: header);
    if (response.statusCode == 200) {
      Get.offNamed(AppRoutes.logInScreen);
    } else {
      debugPrint("error set password ${response.statusText}");
      Fluttertoast.showToast(msg: "${response.statusText}");
    }
    setPasswordLoading(false);
  }
}
