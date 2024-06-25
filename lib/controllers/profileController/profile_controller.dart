import 'dart:io';
import 'package:get/get.dart';
import '../../helpers/prefs_helpers.dart';
import '../../models/profile_model.dart';
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
  getProfileData() async {
    setRxRequestStatus(Status.loading);
    var userId = await PrefsHelper.getString(AppConstants.id);
    var response =
        await ApiClient.getData(ApiConstants.getProfileEndPoint(userId));

    if (response.statusCode == 200) {
      profileModel.value = ProfileModel.fromJson(response.body);
      //await PrefsHelper.setString(AppConstants.subscription, profileModel.value.data?.attributes?.subscription);
      setRxRequestStatus(Status.completed);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
    }
  }

  //===========================> update profile <============================
  var loading = false.obs;

  editProfile(
    String name,
    phoneNumber,
    File? image,
  ) async {
    var number = await PrefsHelper.getString(AppConstants.phoneNumber);
    print("UserId>>${number}");
    List<MultipartBody> multipartBody =
        image == null ? [] : [MultipartBody("image", image)];
    Map<String, String> body = {
      "name": name,
      "phone": number,
    };

    var response = await ApiClient.patchMultipartData(
      ApiConstants.updateProfileEndPoint,
      body,
      multipartBody: multipartBody,
    );
    print(
        "=========== Response body : ${response.body} \nand status code : ${response.statusCode}");
    if (response.statusCode == 200) {
      profileModel.value =
          ProfileModel.fromJson(response.body['data']['attributes']);
      getProfileData();
      profileModel.refresh();
      Get.back();
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
