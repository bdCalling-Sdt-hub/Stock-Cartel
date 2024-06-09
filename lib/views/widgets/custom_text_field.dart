import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_icons.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final String? obscureCharacrter;
  final Color? filColor;
  final Widget? prifixicon;
  final String? labelText;
  final String? hintText;
  final double? contenpaddingHorizontal;
  final double? contenpaddingVertical;
  final Widget? sufixicons;
  final FormFieldValidator? validator;
  final VoidCallback? onTab;
  final bool isPassword;
  final bool? isEmail;
  final bool? readOnly;

  const CustomTextField({
    super.key,
    this.contenpaddingHorizontal,
    this.contenpaddingVertical,
    this.hintText,
    this.prifixicon,
    this.sufixicons,
    this.validator,
    this.isEmail,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isObscureText = false,
    this.obscureCharacrter = '*',
    this.filColor,
    this.labelText,
    this.isPassword = false,
    this.readOnly = false,
    this.onTab,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTab,
      readOnly: widget.readOnly!,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscuringCharacter: widget.obscureCharacrter!,
      validator: widget.validator,
      /*validator: widget.validator ??
              (value) {
            if (widget.isEmail == null) {
              if (value!.isEmpty) {
                return "Please enter ${widget.hintText!.toLowerCase()}";
              } else if (widget.isPassword) {
                bool data = AppConstants.passwordValidator.hasMatch(value);
                if (value.isEmpty) {
                  return "Please enter ${widget.hintText!.toLowerCase()}";
                } else if (!data) {
                  return "Insecure password detected.";
                }
              }
            } else {
              bool data = AppConstants.emailValidator.hasMatch(value!);
              if (value.isEmpty) {
                return "Please enter ${widget.hintText!.toLowerCase()}";
              } else if (!data) {
                return "Please check your email!";
              }
            }
            return null;
          },*/
      cursorColor: AppColors.primaryColor,
      obscureText: widget.isPassword ? obscureText : false,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: widget.contenpaddingHorizontal ?? 12.w,
            vertical: widget.contenpaddingVertical ?? 16.w),
        filled: true,
        fillColor: widget.filColor ?? AppColors.fillColor,
        prefixIcon: widget.prifixicon,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: toggle,
                child:
                    _suffixIcon(obscureText ? AppIcons.eyeOff : AppIcons.eye),
              )
            : widget.sufixicons,
        prefixIconConstraints: BoxConstraints(minHeight: 24.h, minWidth: 24.w),
        suffixIconConstraints: BoxConstraints(minHeight: 24.h, minWidth: 24.w),
        errorStyle: TextStyle(color: Colors.red),
        suffixIconColor: AppColors.primaryColor,
        prefixIconColor: AppColors.primaryColor,
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppColors.hintColor, fontFamily: 'Poppins'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColors.primaryColor,
          ),
        ),
        errorBorder: _errorBuildOutlineInputBorder(),
        focusedBorder: _buildOutlineInputBorder(),
        enabledBorder: _buildOutlineInputBorder(),
        disabledBorder: _buildOutlineInputBorder(),
      ),
    );
  }

  _suffixIcon(String icon) {
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      child: SvgPicture.asset(
        color: AppColors.primaryColor,
        icon,
      ),
    );
  }

  _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.w,
        color: AppColors.primaryColor,
      ),
    );
  }

  _errorBuildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.w,
        color: Colors.red,
      ),
    );
  }
}
