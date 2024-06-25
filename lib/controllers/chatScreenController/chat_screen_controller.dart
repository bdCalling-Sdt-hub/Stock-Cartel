import 'dart:async';
import 'dart:io';
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




  listenMessage(String chatId) async {
    SocketService.socket.on("chat/lastMessage::$chatId", (data) {
      ChatModel demoData = ChatModel.fromJson(data);
        chatList.add(demoData);
        chatList.refresh();
        update();
        debugPrint("=========> Response Message $data");
    });
  }

  offSocket(String chatId) {
    SocketService.socket.off("chat/lastMessage::$chatId");
    debugPrint("Socket off New message");
  }



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

  sendMessage(String message, {required String chatId}) async {
    var userId =await PrefsHelper.getString(AppConstants.id);
    var body =
      {
        "roomId": chatId,
        "senderId":userId,
        "text":message,
        "messageType":"text"
    };
    print("Message body : $body");
    var response = await SocketService.emitWithAck("chat/send", body);
    debugPrint("Message send response : $body");
  }


  sendFile(String message, {required String chatId ,required String userId,required String image})async{
   
    var body={
      'roomId': chatId,
      'senderId': userId,
      'messageType': 'image',
      'text':message
    };
    List<MultipartBody> multipartBody=[
      MultipartBody("image",File(image))
    ];
    var response = await ApiClient.postMultipartData(ApiConstants.chatsSendFile, body,multipartBody: multipartBody);
    if(response.statusCode==200){
      
    }else{
      ApiChecker.checkApi(response);
    }
    

  }

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