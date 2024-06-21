import 'package:get/get.dart';
import 'package:stock_cartel/services/api_constants.dart';
import '../../helpers/prefs_helpers.dart';
import '../../models/message_model.dart';
import '../../services/api_checker.dart';
import '../../services/api_client.dart';
import '../../utils/app_constants.dart';

class MessageController extends GetxController {
  var groupList = <MessageModel>[].obs;
  Status status = Status.completed;
  int currentIndex = 0;
  int page = 1;

  @override
  void onInit() {
    super.onInit();
  }

  getMessage(String roomId) async {
    if (page == 1) {
      status = Status.loading;
      update();
    }
    var response = await ApiClient.getData(
      "${ApiConstants.getMessageEndPoint}?roomId=$roomId&page=$page&limit=15",
    );

    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Authorization': 'Bearer $bearerToken',
    };
    print(headers);

    /*final response = await ApiClient.getData(
        ApiConstants.getMessageEndPoint(roomId),
        headers: headers);*/

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.body['data']['attributes'];
      groupList.value =
          jsonResponse.map((data) => MessageModel.fromJson(data)).toList();
      status = Status.completed;
    } else {
      Get.snackbar('Error', 'Failed to load message');
      ApiChecker.checkApi(response);
    }
  }
}
