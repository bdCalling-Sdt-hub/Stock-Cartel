import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stock_cartel/services/api_constants.dart';
import '../../helpers/prefs_helpers.dart';
import '../../models/group_list_model.dart';
import '../../utils/app_constants.dart';

class GroupListController extends GetxController {
  var groupList = <GroupListModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getGroupList();
  }

  getGroupList() async {
    try {
      isLoading(true);
      String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
      var headers = {
        'Authorization': 'Bearer $bearerToken',
        'Cookie': 'i18next=en'
      };
      print(headers);

      final response = await http.get(Uri.parse(ApiConstants.groupListEndPoint), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        groupList.value =
            jsonResponse.map((data) => GroupListModel.fromJson(data)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load group list');
      }
    } catch (e) {
      print(e);
      debugPrint("Error $e");
      Get.snackbar('Error', 'Error to load group list');
    }
    isLoading(false);
  }
}
