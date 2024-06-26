import '../models/language_model.dart';

class AppConstants {
  //=======================Prefs Helper data===============================>
  static const String bearerToken = "BearerToken";
  static const String phoneNumber = "PhoneNumber";
  static String isLogged = "IsLogged";
  static String id = "id";
  static String isOnboard = "IsOnboard";
  static String subscription = "Subscription";
  static String signInType = "SignInType";
  static String isFutureDate = "isFutureDate";
  static String APP_NAME = "Stock-Cartel";
  static String THEME = "theme";
  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';
  static RegExp emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp passwordValidator = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
  static List<LanguageModel> languages = [
    LanguageModel(
        languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(
        languageName: 'Spanish', countryCode: 'ES', languageCode: 'es'),
  ];
  //===================payment=======================>
  String _merchant_key="";
  String _merchant_id="";
  static String return_url="https://url/success";
  static String cancel_url="https://url/cancel";
  static String notify_url="https://url/notify";


  get getMerchantKey{
    return _merchant_key;
  }

  get getMerchantId{
    return _merchant_id;
  }






}

enum Status { loading, completed, error, internetError }

enum Role { client, admin }
