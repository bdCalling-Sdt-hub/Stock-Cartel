import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/services/api_constants.dart';
import 'package:stock_cartel/services/socket_service.dart';
import '../../helpers/prefs_helpers.dart';
import '../../models/chat_model.dart';
import '../../services/api_checker.dart';
import '../../services/api_client.dart';
import '../../utils/app_constants.dart';

class ChatController extends GetxController {
  late ScrollController scrollController;
  TextEditingController messageCtrl = TextEditingController();
  RxList<ChatModel> chatList = <ChatModel>[].obs;
  int page = 1;
  var totalPage = (-1);
  var currentPage = (-1);
  var loading = false.obs;
  var isLoadMoreRunning=false.obs;

  // listenMessage(String chatId) async {
  //   SocketService.socket.on("new-message::$chatId", (data) {
  //     ChatModel demoData = ChatModel.fromJson(data);
  //     if (userId != demoData.senderId!.id) {
  //       chatList.add(demoData);
  //       chatList.refresh();
  //       update();
  //       debugPrint("=========> Response Message $data");
  //     }
  //   });
  // }

  offSocket(String chatId) {
    SocketService.socket.off("new-message::$chatId");
    debugPrint("Socket off New message");
  }

  // readMessage(String chatId)async{
  //   var userId= await PrefsHelper.getString(AppConstants.userId);
  //   SocketService.emit("read",{
  //     "chat_id":chatId,
  //     "user_id":userId
  //   });
  // }

  fastLoad(String chatId) async {
    page = 1;
    loading(true);
    Response response =
    await ApiClient.getData(ApiConstants.getMessageEndPoint(chatId, page.toString()));
    if (response.statusCode == 200) {
      currentPage = response.body['pagination']['currentPage'];
      totalPage = response.body['pagination']['totalPages'];
      chatList.value = List<ChatModel>.from(response.body['data']['attributes']
          .map((x) => ChatModel.fromJson(x)));
      chatList.refresh();
      loading(false);
      if(chatList.isNotEmpty){
        scrollTime();
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  loadMore(String chatId) async {
    print("load more");
    if (loading.value != true && isLoadMoreRunning.value == false && totalPage != currentPage) {

      page += 1;
      Response response =
      await ApiClient.getData(ApiConstants.getMessageEndPoint(chatId, page.toString()));

      if (response.statusCode == 200) {
        var demoList = List<ChatModel>.from(response.body['data']['attributes']
            .map((x) => ChatModel.fromJson(x)));
        chatList.addAll(demoList);
        chatList.refresh();
        update();
        currentPage = response.body['pagination']['currentPage'];
        totalPage = response.body['pagination']['totalPages'];
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }

  ///  get user id


  ///  send message

  // sendMessage(String message, {required String chatId,required String userId}) async {
  //   var body = {
  //     "chat": chatId,
  //     "sender": userId,
  //     "receiver": "admin",
  //     "message": message
  //   };
  //   var response =
  //   await SocketApi.emitWithAck(SocketConstants.newMessageEvent, body);
  //   if (response['status'] == "Success") {
  //     ChatModel demoData = ChatModel.fromJson(response['message']);
  //     chatList.add(demoData);
  //     chatList.refresh();
  //     update();
  //     messageCtrl.clear();
  //     scrollToEnd();
  //   }
  // }

  ///  scroll bottom and end
  scrollToEnd() {
    Timer(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 100), curve: Curves.decelerate);
      }
    });
  }

  ///  scroll fast time
  scrollTime() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      scrollController.jumpTo(
        scrollController.position.minScrollExtent,
      );
    });
  }
}