import '../data/api/api_helper.dart';
import '../data/api/end_points.dart';

class UserService {
  Future<dynamic> createUser(Map<String, dynamic> userData) async {
    final response = await ApiHelper.post(ApiEndPoints.REGISTERUSER, userData);
    return response;
  }

  Future<dynamic> updateDeviceToken(String deviceToken) async {
    final response = await ApiHelper.put(ApiEndPoints.updateDeviceToken, {
      "deviceToken": deviceToken,
    });
    return response;
  }

  Future<dynamic> login(Map<String, dynamic> loginData) async {
    final response = await ApiHelper.post(ApiEndPoints.LOGIN, loginData);
    return response;
  }

  Future<dynamic> verifyOtp(String otp, String email) async {
    final response = await ApiHelper.post(
        ApiEndPoints.verifyOtp, {"otp": otp, "email": email});
    return response;
  }

  Future<dynamic> getUser(String userId) async {
    return await ApiHelper.get("/users/$userId");
  }

  Future<dynamic> updateUser(String userId, Map<String, dynamic> data) async {
    return await ApiHelper.put("/users/$userId", data);
  }

  Future<dynamic> deleteUser(String userId) async {
    return await ApiHelper.delete("/users/$userId");
  }
}
