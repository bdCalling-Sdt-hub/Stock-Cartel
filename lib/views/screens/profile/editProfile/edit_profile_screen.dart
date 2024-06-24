import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stock_cartel/helpers/prefs_helpers.dart';
import 'package:stock_cartel/services/api_constants.dart';
import '../../../../controllers/profileController/profile_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileController _profileController = Get.put(ProfileController());
  final _nameController = TextEditingController();
  final _phoneNumberController =
      TextEditingController(text: PrefsHelper.myPhone);
  var parameter = Get.parameters;
  Uint8List? _image;
  File? selectedIMage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      var profileData = _profileController.profileModel.value.data?.attributes;
      _nameController.text = "${profileData?.name}";
    });
  }

  @override
  Widget build(BuildContext context) {
    _profileController.getProfileData();
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.updateProfile.tr,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          var profileData =
              _profileController.profileModel.value.data?.attributes;
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 750.h,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 22.h),
                    Center(
                      child: Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 60.r,
                                  backgroundImage: MemoryImage(_image!))
                              : Container(
                                  clipBehavior: Clip.antiAlias,
                                  height: 100.h,
                                  width: 100.w,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: profileData?.image?.publicFileUrl ==
                                              null ||
                                          profileData?.image?.publicFileUrl ==
                                              ''
                                      ? CachedNetworkImage(
                                          imageUrl:
                                              "${ApiConstants.imageBaseUrl}/${profileData?.image?.publicFileUrl}",
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl:
                                              "${ApiConstants.imageBaseUrl}/${profileData?.image?.publicFileUrl}",
                                          fit: BoxFit.cover,
                                        )),
                          Positioned(
                              bottom: 12.h,
                              right: 0.w,
                              child: GestureDetector(
                                  onTap: () {
                                    showImagePickerOption(context);
                                  },
                                  child: SvgPicture.asset(AppIcons.editCam)))
                        ],
                      ),
                    ),
                    //======================================> Text From Field Section <===============================================
                    SizedBox(height: 16.h),
                    CustomTextField(
                        controller: _nameController,
                        hintText: 'Enter your name',
                        prifixicon: _prefixIcon(AppIcons.person)),
                    SizedBox(height: 16.h),
                    //=================================> Phone Number <=========================
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      controller: _phoneNumberController,
                      hintText: '${profileData?.phone}',
                      prifixicon: _prefixIcon(AppIcons.phone),
                    ),
                    SizedBox(height: 16.h),

                    const Spacer(),

                    //===========================> Update profile button <===================
                    Obx(
                      () => CustomButton(
                          text: AppStrings.updateProfile.tr,
                          loading: _profileController.loading.value,
                          onTap: () {
                            _profileController.editProfile(_nameController.text,
                                _phoneNumberController.text, selectedIMage);
                          }),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _prefixIcon(String icon) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 16.w),
      child: SvgPicture.asset(
        icon,
        fit: BoxFit.contain,
        color: AppColors.primaryColor,
      ),
    );
  }

  //==================================> ShowImagePickerOption Function <===============================

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
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 50.w,
                              color: AppColors.primaryColor,
                            ),
                            CustomText(text: 'Gallery'.tr)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(Icons.camera_alt,
                                size: 50.w, color: AppColors.primaryColor),
                            CustomText(text: 'Camera'.tr)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //==================================> Gallery <===============================
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }

//==================================> Camera <===============================
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }
}
