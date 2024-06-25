import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;

import '../../models/subscription_model.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';
import '../../utils/app_constants.dart';


class SubscriptionController extends GetxController {
  AppConstants appConstants = AppConstants();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSubScription();
  }

  RxBool subscriptionLoading = false.obs;
  RxList subscriptionData = [].obs;
  SubscriptionModel subscriptionModel = SubscriptionModel.fromJson({});
  getSubScription() async {
    subscriptionLoading(true);
    var response = await ApiClient.getData(ApiConstants.subscriptionEndPoint);
    if (response.statusCode == 200) {
      //subscriptionData.value = List<SubscriptionModel>.from(response.body['data']['attributes'].map((e) => SubscriptionModel.fromJson(e)));
      if (subscriptionModel.data?.attributes != null) {
        subscriptionData.addAll(subscriptionModel.data!.attributes!);
      }
      update();
      subscriptionLoading(false);
    }
  }

  RxInt selectedIndex = 0.obs;
  var subscriptionName = ''.obs;
  RxBool submitFormLoading = false.obs;

  ///=================================================>
  void submitForm(BuildContext context, String price, subscription, startDate, endDate) async {
    submitFormLoading(true);
    const url = '';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'merchant_id': appConstants.getMerchantId,
        'merchant_key': appConstants.getMerchantKey,
        'amount': '$price',
        'item_name': '$subscription',
        'return_url': AppConstants.return_url,
        'cancel_url': AppConstants.cancel_url,
        'notify_url': AppConstants.notify_url,
      },
    );

   /* if (response.statusCode == 200 || response.statusCode == 302) {
      Navigator.push(
          context, MaterialPageRoute(
              builder: (_) => FlutterLocalWebView(
                code: response.body,
                eventId: '',
                startDate: startDate,
                endDate: endDate,
                subscription: subscription,
                subscriptionPrice: price,
              )
      ));

      submitFormLoading(false);
      // Handle successful response
      print('Form submitted successfully');
    } else {
      print('Error submitting form: ${response.statusCode}');
      print('Error submitting form: ${response.body}');
    }*/
  }

  //=====================> Buy Subscription <=========================
  buySubscription(String price, subscription, startDate, endDate) async {
    var body = {
      "subscription": "$subscription",
      "subscriptionStartDate": "$startDate",
      "subscriptionEndDate": "$endDate",
      "price": "$price",
      "transactionId": "0012"
    };
    var response =
    await ApiClient.postData(ApiConstants.subscriptionEndPoint, body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("buy subscription successful");
    }
  }
}