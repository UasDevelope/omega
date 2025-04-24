class ApiEndPoints {
  static get REGISTERUSER => "/auth/register";
  static get LOGIN => "/auth/login";
  static get supplements => "/supplements";
  static String updateStatus(String id) => "/supplements/$id/status";
  static get today => "/supplements/supplements-today";
  static get profile => "/auth/profile";
  static get weekly => "/supplements/progress/daily";
}
