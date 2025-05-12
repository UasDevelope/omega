class ApiEndPoints {
  static get REGISTERUSER => "/auth/register";
  static get LOGIN => "/auth/login";
  static get verifyOtp => "/auth/verify-otp";
  static get updateDeviceToken => "/auth/updateDeviceToken";
  static get supplements => "/supplements";
  static get shareDiary => "/friends/share-diary";
  static get invite => "/friends/invite";
  static String updateStatus(String id) => "/supplements/$id/status";
  static String deleteSupplement(String id) => "/supplements/$id";
  static get today => "/supplements/supplements-today";
  static get profile => "/auth/profile";
  static get weekly => "/supplements/progress/daily";
  static get notification => "/notifications/get-user-notifications";
  static get enableNotification=>"/settings/notifications";
}
