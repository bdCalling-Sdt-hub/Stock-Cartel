import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stock_cartel/services/api_constants.dart';
import '../../helpers/prefs_helpers.dart';
import '../../models/chat_screen_model.dart';
import '../../services/api_checker.dart';
import '../../services/api_client.dart';
import '../../utils/app_constants.dart';

class ChatScreenController extends GetxController {
  var messageList = [].obs;
  var isLoading = true.obs;

  ChatScreenModel chatScreenModel = ChatScreenModel.fromJson({});

  getMessages(String roomId) async {
    isLoading(true);
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {'Authorization': 'Bearer $bearerToken'};
    final response = await ApiClient.getData(
        ApiConstants.getMessageEndPoint(roomId),
        headers: headers);
    if (response.statusCode == 200) {
      // List<dynamic> jsonResponse = response.body['data']['attributes'];
       chatScreenModel = ChatScreenModel.fromJson( response.body);

       messageList.addAll(chatScreenModel.data!.attributes!);

       print(messageList.length);

      isLoading(false);
    } else {
      ApiChecker.checkApi(response);
    }
  }

 /* getMessageById(String roomId) async {
    isLoading(true);
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {'Authorization': 'Bearer $bearerToken'};
    final response = await ApiClient.getData(
        ApiConstants.getMessageEndPoint(roomId),
        headers: headers);
    if (response.statusCode == 200) {
      return MessageModel.fromJson(json.decode(response.body));
    } else {
      ApiChecker.checkApi(response);
    }
  }*/
}
