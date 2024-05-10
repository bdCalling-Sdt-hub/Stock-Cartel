import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_cartel/utils/app_colors.dart';

import '../../../utils/app_strings.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class SubscriptionScreen extends StatefulWidget {
  SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedIndex = (0);
  bool isSelected = false;

  void setSelectedIndex(int index) {
    selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.subscription.tr,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                top: 24.h,
                bottom: 64.h,
                text: AppStrings.pleaseChoose.tr,
                fontWeight: FontWeight.w500,
                fontsize: 18.sp,
                textAlign: TextAlign.start,
                maxline: 4,
              ),
              //====================================> Select Plan Text <=========================
              Center(
                child: CustomText(
                  text: AppStrings.selectYourPlan.tr,
                  fontWeight: FontWeight.w500,
                  bottom: 8.h,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics:const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      bool isSelected = selectedIndex == index;
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            setSelectedIndex(index);
                          });
                        },

                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          width: 350.w,
                          height: 75.h,
                          decoration: BoxDecoration(
                              border: Border.all(width: isSelected ? 2.w : 1.w, color: isSelected ? AppColors.primaryColor: Color(0xffB3D8B0)),
                              borderRadius: BorderRadius.circular(4.w),
                             color:  isSelected ? const Color(0xffe6f2e6): AppColors.fillColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: '1 WEEK',
                                  fontWeight: FontWeight.w500,
                                  fontsize: 14.w,
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                      text: '\$9.99',
                                      fontWeight: FontWeight.w500,
                                      fontsize: 20.w,
                                      color: isSelected ? AppColors.primaryColor: Colors.black,
                                    ),
                                    CustomText(
                                      text: '\/week',
                                    ),
                                    SizedBox(width: 12.w),
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

              //====================================> Select Plan Button  <=========================
              SizedBox(height: 8.h),
              CustomButton(
                  text: AppStrings.selectPlan.tr,
                  onTap: () {
                    //Get.toNamed(AppRoutes.createAccountScreen);
                  }),
              Center(
                child: CustomText(top: 16.h, text: AppStrings.recurringBilling),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
