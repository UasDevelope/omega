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
    required File profilePictureFile, // Optional profile picture file
  }) async {
    log("🌐 Sending PUT request to: ${ApiEndPoints.profile}");
    // If there's a profile picture, pass it along with the request
    final response = await ApiHelper.postFile(
      ApiEndPoints.profile,
      fileFieldKey:
          'profilePicture', // key should match the backend expected field
      method: 'PUT', name: name, imageFile: profilePictureFile,
    );

    log("📥 API Response: $response");

    if (response.success) {
      log("✅ Profile update successful - parsing updated data");
      return ApiResponse(
        success: true,
        data: UserModel.fromJson(response.data["data"]),
      );
    } else {
      log("❌ Failed to update profile: ${response.message}");
      return ApiResponse(
        success: false,
        message: response.message ?? 'Unknown error',
      );
    }
  }
}
