import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../services/api_checker.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class ChangePasswordController extends GetxController {

//============================> Change Password <==============================
  var changeLoading = false.obs;
  handleChangePassword(String oldPassword, String password) async {
    changeLoading(true);
    var body = {"oldPassword": oldPassword, "newPassword": password};
    var response =
    await ApiClient.postData(ApiConstants.changePasswordEndPoint, json.encode(body));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message'],toastLength:Toast.LENGTH_LONG,gravity: ToastGravity.CENTER,backgroundColor:Colors.green,textColor:Colors.white);
    } else {
      ApiChecker.checkApi(response);
    }
    changeLoading(false);

  }



  //========================> Forgot password setting <====================



  var forgotLoading = false.obs;
  forgotPassword(String email) async {
    forgotLoading(true);
    var body = {"email": email};
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.forgetPasswordEndPoint, json.encode(body),
        headers: header);
    if (response.statusCode == 200) {
      Get.toNamed(AppRoutes.verifyNumberScreen,
          arguments:email);
    } else {
      Fluttertoast.showToast(msg: response.statusText ?? "",backgroundColor: Colors.red,textColor: Colors.white);
    }
    forgotLoading(false);
  }


  //========================> Resend otp <=======================

  var resendOtpLoading = false.obs;

  resendOtp(String email) async {
    resendOtpLoading(true);
    var body = {"email": email};
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.forgetPasswordEndPoint, json.encode(body),
        headers: header);
    if (response.statusCode == 200) {


    } else {
      Fluttertoast.showToast(msg: response.statusText ?? "",backgroundColor: Colors.red,textColor: Colors.white,gravity: ToastGravity.CENTER);
    }
    resendOtpLoading(false);
  }



  //======================> Verify forgot password <=====================


  var verifyLoading = false.obs;
  verifyEmail(
      String  email,
      String code,
      ) async {
    verifyLoading(true);
    var body = {"email":email, "code": code};
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.otpVerifyEndPoint, json.encode(body),
        headers: header);
    if (response.statusCode == 200) {
      Get.toNamed(AppRoutes.setNewPasswordScreen, arguments:email);
    } else {
      Fluttertoast.showToast(msg: response.statusText ?? "");
    }
    verifyLoading(false);
  }

  //===========================> Set password <======================

  var setPasswordLoading = false.obs;
  setPassword(String phone, String password) async {
    setPasswordLoading(true);
    var body = {"phone": phone, "password": password};
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.setPasswordEndPoint, json.encode(body),
        headers: header);
    if (response.statusCode == 200){
      showDialog(context: Get.context!,
          barrierDismissible:false,
          builder:(_)=> AlertDialog(
            title: const Text("Password Changed!"),
            content: const Text("Your password has been changed successfully."),
            actions: [
              TextButton(
                  onPressed:(){
                    Get.back();
                    Get.back();
                    Get.back();
                  }, child:const Text("Ok"))
            ],
          ));

    } else {
      debugPrint("error set password ${response.statusText}");
      Fluttertoast.showToast(msg: "${response.statusText}",);
    }
    setPasswordLoading(false);
  }
}