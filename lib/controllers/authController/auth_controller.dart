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

class AuthController extends GetxController {
  final phoneNumberCTRl = TextEditingController();
  var registerLoading = false.obs;
  var token = "";

  //=================================> Register  <=============================
  handleRegister() async {
    registerLoading(true);
    try {
      Map<String, dynamic> body = {
        "phone": phoneNumberCTRl.text.trim(),
      };
      print("===================> $body");
      var headers = {'Content-Type': 'application/json'};
      Response response = await ApiClient.postData(
        ApiConstants.registerEndPoint,
        jsonEncode(body),
      );
      print("============> ${response.body} and ==> ${response.statusCode}");
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: response.body['message']);
        Get.toNamed(AppRoutes.verifyNumberScreen, parameters: {
          "phone": phoneNumberCTRl.text.trim(),
          "screenType": "register",
        });
        phoneNumberCTRl.clear();
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e, s) {
      print("===> error : $e");
      print("===> error : $s");
    }
    registerLoading(false);
  }

  /*//============================================>  Log in <==============================


  TextEditingController logInPassCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();
  var logInLoading = false.obs;

  handleLogIn() async {
    logInLoading(true);
    var headers = {
      //'Content-Type': 'application/x-www-form-urlencoded'
      'Content-Type': 'application/json'
    };
    Map<String, dynamic> body = {
      'email': phoneNumberCtrl.text.trim(),
      'password': logInPassCtrl.text.trim()
    };
    Response response = await ApiClient.postData(
        ApiConstants.loginEndPoint, json.encode(body),
        headers: headers);
    print("====> ${response.body}");
    if (response.statusCode == 200) {
      await PrefsHelper.setString(AppConstants.bearerToken,
          response.body['data']['attributes']['tokens']['access']['token']);
      await PrefsHelper.setString(
          AppConstants.id, response.body['data']['attributes']['user']['id']);
      await PrefsHelper.setString(AppConstants.isLogged, true);
      Get.offAllNamed(AppRoutes.homeScreen);
      await PrefsHelper.setBool(AppConstants.isLogged, true);
      signInEmailCtrl.clear();
      signInPassCtrl.clear();
    } else {
      Fluttertoast.showToast(msg: response.statusText ?? "");
    }
    logInLoading(false);
  }
*/
 /* //======================================> Resend otp <======================================
  var resendOtpLoading = false.obs;
  resendOtp(String email) async {
    resendOtpLoading(true);
    var body = {"email": email};
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.forgot, json.encode(body),
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
  }*/

  //=====================================> Otp very <====================================
  TextEditingController otpCtrl = TextEditingController();
  var verifyLoading = false.obs;

  handleOtpVery(
      {required String phone,
      required String otp,
      required String type}) async {
    try {
      var body = {'oneTimeCode': otp, 'phone': phone};
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      verifyLoading(true);
      Response response = await ApiClient.postData(
          ApiConstants.otpVerifyEndPoint, body,
          headers: headers);
      print("============${response.body} and ${response.statusCode}");
      if (response.statusCode == 200) {
        await PrefsHelper.setString(
            AppConstants.isLogged, response.body["data"]['attributes']['user']);
        otpCtrl.clear();

        if (type == "forgetPasswordScreen") {
          //Get.toNamed(AppRoutes.resetPasswordScreen,
          //parameters: {"phone": phone});
        } else {
          // Get.offAllNamed(AppRoutes.signInScreen);
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e, s) {
      print("===> e : $e");
      print("===> s : $s");
    }
    verifyLoading(false);
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
