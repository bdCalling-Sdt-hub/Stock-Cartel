import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/prefs_helpers.dart';
import '../../models/profile_model.dart';
import '../../routes/app_routes.dart';
import '../../services/api_checker.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';
import '../../utils/app_constants.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfileData();
  }

  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  Rx<ProfileModel> profileModel = ProfileModel().obs;
  RxBool isProfileLoading = false.obs;

  getProfileData() async {
    setRxRequestStatus(Status.loading);
    String id = await PrefsHelper.getString(AppConstants.id);
    var response = await ApiClient.getData(
      ApiConstants.updateProfileEndPoint,
    );
    print("=============response : ${response.body}");
    if (response.statusCode == 200) {
      profileModel.value =
          ProfileModel.fromJson(response.body['data']['attributes']);
      profileModel.refresh();
      setRxRequestStatus(Status.completed);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
    update();
  }

  //===============================> Update profile <============================
  var loading = false.obs;
  final nameController = TextEditingController();
  final passController = TextEditingController();

  editProfile(String name, phoneNumber, password, File? image) async {
    List<MultipartBody> multipartBody =
        image == null ? [] : [MultipartBody("image", image)];
    Map<String, String> body = {
      "fullName": name,
      "password": password,
      "phone": phoneNumber,
    };

    var response = await ApiClient.patchMultipartData(
      ApiConstants.updateProfileEndPoint,
      body,
      multipartBody: multipartBody,
    );
    print(
        "===========> Response body : ${response.body} \nand status code : ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      profileModel.value =
          ProfileModel.fromJson(response.body['data']['attributes']);
      profileModel.refresh();
      Get.offAllNamed(AppRoutes.logInScreen);
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
