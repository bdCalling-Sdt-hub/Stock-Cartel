import 'package:get/get.dart';
import 'package:stock_cartel/services/api_checker.dart';
import 'package:stock_cartel/services/api_constants.dart';
import '../../helpers/prefs_helpers.dart';
import '../../models/group_list_model.dart';
import '../../services/api_client.dart';
import '../../utils/app_constants.dart';

class GroupListController extends GetxController {
  var groupList = <GroupListModel>[].obs;
  var isLoading = true.obs;



  @override
  void onInit() {
    getGroupList();
    super.onInit();

  }

  getGroupList() async {
      isLoading(true);
      String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
      var headers = {
        'Authorization': 'Bearer $bearerToken',
      };
      print(headers);

      final response = await ApiClient.getData(ApiConstants.groupListEndPoint, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.body['data']['attributes'];
        groupList.value = jsonResponse.map((data) => GroupListModel.fromJson(data)).toList();
        isLoading(false);
      } else {
        ApiChecker.checkApi(response);
      }

  }
}
