class ApiConstants {
  static const String baseUrl = "http://192.168.10.46:3032/api/v1";
  static const String imageBaseUrl = "http://192.168.10.46:3032";
  static const String socketUrl="http://192.168.10.46:3032";

  static const String registerEndPoint = "/user/register";
  static const String otpVerifyEndPoint = "/user/otp-verify";
  static const String updateProfileEndPoint = "/user/update-profile";
  static const String loginEndPoint = "/user/login";
  static const String setPasswordEndPoint = "/user/set-password";
  static const String changePasswordEndPoint = "/user/change-password";
  static const String forgetPasswordEndPoint = "/user/forget-password";
  static const String groupListEndPoint = "/groups/group-list";
  static String getMessageEndPoint(String roomId,String page) => "/groups/$roomId/message?page=$page";
  static String getPrivacyPolicyEndPoint = "/settings/privacy-policy";
  static String getAboutUsEndPoint = "/settings/about-us";
  static String getTermsConditionEndPoint = "/settings/terms-condition";
  static String chatsSendFile="/chats/send-file";
  static String getProfileEndPoint(String userId) => "/user/single-user/$userId";

}
