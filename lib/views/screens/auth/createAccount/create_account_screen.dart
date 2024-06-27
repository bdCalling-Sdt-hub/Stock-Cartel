import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_cartel/controllers/auth_controller.dart';
import 'package:stock_cartel/controllers/create_account_controller.dart';
import 'package:stock_cartel/utils/app_colors.dart';
import 'package:stock_cartel/utils/app_images.dart';
import '../../../../services/api_constants.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _createAccountController = Get.put(CreateAccountController());
  final _authController = Get.put(AuthController());
  final TextEditingController nameCTRl = TextEditingController();
  final TextEditingController passwordCTRl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var parameter = Get.parameters;
  Uint8List? _image;
  File? selectedIMage;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.createAccount.tr,
          fontsize: 18.h,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: AppStrings.pleaseFillUp.tr,
                fontWeight: FontWeight.w500,
                fontsize: 18.sp,
                textAlign: TextAlign.start,
                maxline: 3,
              ),
              SizedBox(height: 16.h),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundImage: _image != null
                          ? MemoryImage(_image!)
                          : (parameter['image'] != null && parameter['image']!.isNotEmpty
                          ? NetworkImage('${ApiConstants.imageBaseUrl}${parameter['image']}')
                          : AssetImage(AppImages.person)) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0.h,
                      right: 5.w,
                      child: GestureDetector(
                        onTap: () {
                          showImagePickerOption(context);
                        },
                        child: SvgPicture.asset(AppIcons.editCam),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: CustomText(
                  top: 24.h,
                  text: AppStrings.uploadProfilePhoto.tr,
                  fontWeight: FontWeight.w500,
                  fontsize: 18.sp,
                  textAlign: TextAlign.start,
                  maxline: 3,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    //=================================> Name TextField <==================================
                    SizedBox(height: 24.h),
                    CustomTextField(
                      controller: nameCTRl,
                      hintText: AppStrings.name.tr,
                    ),
                    //=================================> Password TextField <==================================
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: passwordCTRl,
                      hintText: AppStrings.password.tr,
                      isPassword: true,
                    ),
                    SizedBox(height: 12.h),
                    CustomText(
                      text: AppStrings.yourPasswordMust.tr,
                      fontsize: 14.sp,
                      textAlign: TextAlign.start,
                      maxline: 3,
                    ),
                    SizedBox(height: 175.h),
                    //=================================> Create Account Button <==================================
                    CustomButton(
                      loading: _createAccountController.loading.value,
                      text: AppStrings.createAccount.tr,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _createAccountController.createProfile(
                            nameCTRl.text,
                            passwordCTRl.text,
                            parameter['phone'],
                            selectedIMage
                          );
                        }
                      },
                    ),
                    SizedBox(height: 74.h)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.backgroundColor,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickImageFromGallery,
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 50.w,
                        ),
                        CustomText(text: 'Gallery')
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: _pickImageFromCamera,
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 50.w,
                        ),
                        CustomText(text: 'Camera')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _pickImageFromGallery() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }

  Future _pickImageFromCamera() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }
}
