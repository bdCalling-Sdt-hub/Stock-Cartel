import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/controllers/group_list_controller.dart';
import 'package:stock_cartel/models/join_group_model.dart';
import 'package:stock_cartel/services/api_checker.dart';
import 'package:stock_cartel/services/api_constants.dart';
import '../helpers/prefs_helpers.dart';
import '../services/api_client.dart';
import '../utils/app_constants.dart';

class JoinGroupController extends GetxController {
  var joinGroupList = <Attribute>[].obs;
  var isLoading = true.obs;
  final _groupListController = Get.put(GroupListController());

  @override
  void onInit() {
    fetchJoinGroupList();
    super.onInit();
  }

  fetchJoinGroupList() async {
    isLoading(true);
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {'Authorization': 'Bearer $bearerToken'};
    print(headers);

    final response = await ApiClient.getData(ApiConstants.joinGroupListEndPoint, headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.body['data']['attributes'];
      joinGroupList.value = jsonResponse.map((data) => Attribute.fromJson(data)).toList();
      isLoading(false);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  //=================================> Join Group Method <=========================
  var joinLoading = false.obs;
  postJoinGroupList(String roomId,int index) async {
    joinLoading(true);
   var headers = {'Content-Type': 'application/json'};
    var body = {
      "roomId":roomId
    };

    print('API Body: $roomId');
    var response = await ApiClient.postData(ApiConstants.joinUserEndPoint, body);

    print('Response Post Method : ${response.statusCode}');
    if (response.statusCode == 200) {
      _groupListController.getGroupList();
      joinGroupList[index].isJoin=true;
      joinGroupList.refresh();
    } else if(response.statusCode==404){
      isLoading(false);
    }else {
      ApiChecker.checkApi(response);
    }
    joinLoading(false);
  }
}
