import 'dart:convert';
import 'package:get/get.dart';
import '../../models/notification_model.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class NotificationController extends GetxController {
  RxInt page = 1.obs;
  var totalPage = (-1);
  var currentPage = (-1);
  var totalResult = (-1);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotifications();
  }

  void loadMore() {
    if (totalPage > page.value) {
      page.value += 1;
      print("=======> page $page");
      update();
      getNotifications();
    } else {
      update();
    }
  }

  RxBool notificationLoading = false.obs;
  RxList notificationsList = [].obs;
  NotificationModel notificationModel = NotificationModel.fromJson({});

  getNotifications() async {
    if (page == 1) {
      notificationLoading(true);
    }
    var response = await ApiClient.getData('${ApiConstants.notificationsEndPoint}?limit=15&page=$page');
    if (response.statusCode == 200) {
      if (response.body['data']['attributes'] != null) {
        print('========================== ${response.body}');
        print('========================== ${response.body.runtimeType}');
        totalPage =
            jsonDecode(response.body['pagination']['totalPages'].toString());
        currentPage =
            jsonDecode(response.body['pagination']['currentPage'].toString());
        totalResult = jsonDecode(
            response.body['pagination']['totalNotification'].toString());
        notificationModel = NotificationModel.fromJson(response.body);
        if (notificationModel.data?.attributes != null) {
          notificationsList.addAll(notificationModel.data!.attributes!);
        }
        update();
        notificationLoading(false);
      }
    }
  }
}
