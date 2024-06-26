import 'package:get/get.dart';
import 'package:stock_cartel/models/join_group_model.dart';
import 'package:stock_cartel/services/api_checker.dart';
import 'package:stock_cartel/services/api_constants.dart';
import '../../helpers/prefs_helpers.dart';
import '../../services/api_client.dart';
import '../../utils/app_constants.dart';

class JoinGroupController extends GetxController {
  var joinGroupList = <Attribute>[].obs;
  var isLoading = true.obs;

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
}