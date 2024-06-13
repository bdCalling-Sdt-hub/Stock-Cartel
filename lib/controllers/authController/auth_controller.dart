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
      var responseBody = json.decode(response.body);
      await PrefsHelper.setString(
          AppConstants.bearerToken, responseBody['data']['token']);
      await PrefsHelper.setString(AppConstants.isLogged, true);
      logInPhoneNumberCtrl.clear();
      logInPassCtrl.clear();
    } else {
      Fluttertoast.showToast(msg: response.statusText ?? "Login failed");
    }
    logInLoading(false);
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

/*//=================================> Forgot pass word <==========================================
  TextEditingController phoneNumberCTRl = TextEditingController();
  var forgotLoading = false.obs;

  handleForget() async {
    forgotLoading(true);
    var body = {
      "phone": phoneNumberCTRl.text.trim(),
    };
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var response = await ApiClient.postData(
        ApiConstants.forgotPasswordEndPoint, json.encode(body),
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.toNamed(AppRoutes.verifyNumberScreen, parameters: {
        "phone": phoneNumberCTRl.text.trim(),
        "screenType": "forgetPasswordScreen",
      });

      forgetEmailTextCtrl.clear();
    } else {
      ApiChecker.checkApi(response);
    }
    forgotLoading(false);
  }*/

/*//====================================> Handle Change password <================================
  var changeLoading = false.obs;
  TextEditingController oldPasswordCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  handleChangePassword(String oldPassword, String newPassword) async {
    changeLoading(true);
    var body = {"oldPassword": oldPassword, "newPassword": newPassword};

    var response =
        await ApiClient.postData(ApiConstants.changePasswordEndPoint, body);
    print("===============> ${response.body}");
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: response.body['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white);
      // Get.offAllNamed(AppRoutes.signInScreen);
      Get.back();
      Get.back();
    } else {
      ApiChecker.checkApi(response);
    }
    changeLoading(false);
  }*/

/* //====================================> Reset password <==================================
  var resetPasswordLoading = false.obs;

  resetPassword(String email, String password) async {
    print("=======> $email, and $password");
    resetPasswordLoading(true);
    var body = {"email": email, "password": password};
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.resetPasswordEndPoint, json.encode(body),
        headers: header);
    if (response.statusCode == 200) {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
                title: const Text("Password reset!"),
                content:
                    const Text("Your password has been reset successfully."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                        Get.back();
                        Get.back();
                        Get.back();
                      },
                      child: const Text("Ok"))
                ],
              ));
    } else {
      debugPrint("error set password ${response.statusText}");
      Fluttertoast.showToast(
        msg: "${response.statusText}",
      );
    }
    resetPasswordLoading(false);
  }*/
}
