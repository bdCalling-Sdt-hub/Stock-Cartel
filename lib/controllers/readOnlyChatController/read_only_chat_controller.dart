import 'package:get/get.dart';
import 'package:stock_cartel/services/api_constants.dart';
import '../../helpers/prefs_helpers.dart';
import '../../models/read_only_chat_screen_model.dart';
import '../../services/api_checker.dart';
import '../../services/api_client.dart';
import '../../utils/app_constants.dart';

class ReadOnlyChatController extends GetxController {
  var messageList = [].obs;
  var isLoading = true.obs;

  OnlyReadChatScreenModel onlyReadChatScreenModel = OnlyReadChatScreenModel.fromJson({});

  getMessages(String roomId) async {
    isLoading(true);
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {'Authorization': 'Bearer $bearerToken'};
    final response = await ApiClient.getData(
        ApiConstants.getMessageEndPoint(roomId),
        headers: headers);
    if (response.statusCode == 200) {
      onlyReadChatScreenModel = OnlyReadChatScreenModel.fromJson( response.body);
      messageList.addAll(onlyReadChatScreenModel.data!.attributes!);
      print(messageList.length);
      isLoading(false);
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
