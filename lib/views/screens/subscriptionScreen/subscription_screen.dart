import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/utils/app_colors.dart';
import 'package:stock_cartel/views/widgets/custom_page_loading.dart';
import '../../../controllers/subscription_controller.dart';
import '../../../models/subscription_model.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class SubscriptionScreen extends StatefulWidget {
  SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final SubscriptionController _subscriptionController = Get.put(
      SubscriptionController());
  int selectedIndex = (0);
  bool isSelected = false;
  DateTime now = DateTime.now();
  String startDate = '${DateTime.now()}';

  void setSelectedIndex(int index) {
    selectedIndex = index;
  }
  String? entDate;

  @override
  Widget build(BuildContext context) {
    print("${_subscriptionController
        .subscriptionData.length}");
    if (_subscriptionController.selectedIndex.value == 0) {
      _subscriptionController.subscriptionName.value = 'week';
      entDate = "${now.add(const Duration(days: 7))}";
    } else if (_subscriptionController.selectedIndex.value == 1) {
      _subscriptionController.subscriptionName.value = 'month';
      entDate = "${now.add(const Duration(days: 30))}";
    }
    else {
      _subscriptionController.subscriptionName.value = 'year';
      entDate = "${now.add(const Duration(days: 365))}";
    }
    print("===>selected index ${_subscriptionController.selectedIndex
        .value} and ${_subscriptionController.subscriptionName.value}");
    print("now $now and endDate ${now.add(Duration(days: 3))}");

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.subscription.tr,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              bottom: 64.h,
              text: AppStrings.pleaseChoose.tr,
              fontWeight: FontWeight.w500,
              fontsize: 18.sp,
              textAlign: TextAlign.start,
              maxline: 4,
            ),
            //==========================> Select Plan Text <====================
            Center(
              child: CustomText(
                text: AppStrings.selectYourPlan.tr,
                fontWeight: FontWeight.w500,
                bottom: 8.h,
              ),
            ),
            Obx(() =>
                Expanded(
                  child: _subscriptionController.subscriptionLoading.value
                      ? const CustomPageLoading()
                      : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _subscriptionController.subscriptionData
                          .length,
                      itemBuilder: (context, index) {
                      //  print("${_subscriptionController.subscriptionData[index]}");
                        var data = _subscriptionController
                            .subscriptionData[index];
                        bool isSelected = selectedIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              setSelectedIndex(index);
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: isSelected ? 2.w : 1.w,
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : const Color(0xffB3D8B0)),
                              borderRadius: BorderRadius.circular(4.w),
                              color: isSelected
                                  ? const Color(0xffe6f2e6)
                                  : AppColors.fillColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 12.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  CustomText(
                                    text: "1 ${data["title"]}",
                                    fontWeight: FontWeight.w500,
                                    fontsize: 14.w,
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: '\$${data["price"]}',
                                        fontWeight: FontWeight.w500,
                                        fontsize: 18.w,
                                        color: isSelected
                                            ? AppColors.primaryColor
                                            : Colors.black,
                                      ),
                                      CustomText(
                                        text: '\/${data["duration"]}',
                                        fontsize: 14.w,
                                      ),
                                      SizedBox(width: 8.w),
                                      CustomText(
                                        text: '(3- Days free trial)',
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
            ),

            //=========================> Select Plan Button  <==================
            SizedBox(height: 8.h),
            Obx(() => CustomButton(
                  text: AppStrings.selectPlan.tr,
                loading: _subscriptionController.submitFormLoading.value,
                  onTap: () {
                    _subscriptionController.submitForm(
                        context,
                        '${_subscriptionController.subscriptionData[_subscriptionController.selectedIndex.value].price}',
                        '${_subscriptionController.subscriptionData[_subscriptionController.selectedIndex.value].type}',
                        startDate,
                        entDate);
                  })
            ),
            Center(
              child: CustomText(
                top: 16.h,
                bottom: 24.h,
                text: AppStrings.recurringBilling.tr,
                maxline: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
