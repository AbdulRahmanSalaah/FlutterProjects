class ApiConstants {
  static const String baseUrl = 'https://vcare.integration25.com/api/';
  static const String login = 'auth/login';
  static const String signUp = 'auth/register';
  static const String specializationEP = 'specialization/index';
}

bool rememberMe = false;
String userNametohome = '';

class SharedPrefKeys {
  static const String userToken = 'userToken';
    static const String userName = 'userName'; // New key for user name

}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
