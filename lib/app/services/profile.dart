import 'dart:developer';
import 'dart:io';

import 'package:omega/app/data/api/api_helper.dart';
import 'package:omega/app/data/api/end_points.dart';
import 'package:omega/app/data/models/user_model.dart';

class ProfileServices {
  Future<ApiResponse<UserModel>> getProfile() async {
    log("🌐 Sending GET request to: ${ApiEndPoints.profile}");

    final response = await ApiHelper.get(ApiEndPoints.profile);
    log("📥 API Response: $response");

    // Assuming response is an ApiResponse instance
    if (response.success) {
      log("✅ API success - parsing user data");
      return ApiResponse(
        success: true,
        data: UserModel.fromJson(response.data["data"]),
      );
    } else {
      log("❌ API returned error: ${response.message}");
      return ApiResponse(
        success: false,
        message: response.message ?? 'Unknown error',
      );
    }
  }

  Future<ApiResponse<UserModel>> updateProfile({
    required String name,
    File? profilePictureFile,
  }) async {
    log("🌐 Sending PUT request to: ${ApiEndPoints.profile}");

    late ApiResponse<dynamic> response;

    if (profilePictureFile != null) {
      // Send multipart request with image
      response = await ApiHelper.postFile(
        ApiEndPoints.profile,
        fileFieldKey: 'profilePicture',
        method: 'PUT',
        name: name,
        imageFile: profilePictureFile,
      );
    } else {
      // Send JSON-only request (no file)
      response = await ApiHelper.put(ApiEndPoints.profile, {
        'name': name,
      });
    }

    log("📥 API Response: $response");

    if (response.success) {
      return ApiResponse(
        success: true,
        data: UserModel.fromJson(response.data["data"]),
      );
    } else {
      return ApiResponse(
        success: false,
        message: response.message ?? 'Unknown error',
      );
    }
  }
}
