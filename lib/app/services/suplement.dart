import 'dart:developer';

import 'package:omega/app/data/api/api_helper.dart';
import 'package:omega/app/data/api/end_points.dart';
import 'package:omega/app/data/models/supplement.dart';

import '../data/models/daily_suppliment.dart';

class SupplementServices {
  Future<dynamic> addSupplement(Map<String, dynamic> userData) async {
    var response = await ApiHelper.post(ApiEndPoints.supplements, userData);
    return response;
  }

  Future<ApiResponse<List<SupplementModel>>> todaySupplements() async {
    final ApiResponse rawResponse = await ApiHelper.get(ApiEndPoints.today);

    if (rawResponse.success && rawResponse.data != null) {
      // ✅ First, cast the whole response to Map<String, dynamic>
      final Map<String, dynamic> jsonData =
          rawResponse.data as Map<String, dynamic>;

      // ✅ Then extract just the List part
      final List<dynamic> dataList = jsonData['data'];

      final List<SupplementModel> supplements =
          dataList.map((item) => SupplementModel.fromJson(item)).toList();

      return ApiResponse(
        success: true,
        message: jsonData['message'], // might be null, that’s okay
        data: supplements,
      );
    } else {
      return ApiResponse(
        success: false,
        message: rawResponse.message,
        data: [],
      );
    }
  }

  Future<ApiResponse<DailyDataSuppliment>> weeklySummry() async {
    final ApiResponse rawResponse = await ApiHelper.get(ApiEndPoints.weekly);
    log("Raw response is $rawResponse");

    if (rawResponse.success && rawResponse.data != null) {
      // ✅ First, cast the whole response to Map<String, dynamic>
      final Map<String, dynamic> jsonData =
          rawResponse.data as Map<String, dynamic>;

      // ✅ Parse the entire DailyDataSuppliment model
      final DailyDataSuppliment supplementSummary =
          DailyDataSuppliment.fromJson(jsonData);

      return ApiResponse(
        success: true,
        message: rawResponse.message,
        data: supplementSummary,
      );
    } else {
      return ApiResponse(
        success: false,
        message: rawResponse.message,
        data: null,
      );
    }
  }

  Future<ApiResponse<List<SupplementModel>>> allSupplements() async {
    var response = await ApiHelper.get(ApiEndPoints.supplements);
    if (response.success && response.data != null) {
      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      final List<dynamic> datalist = data["data"];
      final List<SupplementModel> supplementModel =
          datalist.map((items) => SupplementModel.fromJson(items)).toList();
      return ApiResponse(
          success: true,
          message: data['message'], // might be null, that’s okay
          data: supplementModel);
    } else {
      return ApiResponse(success: false, message: response.message, data: []);
    }
  }

  Future<ApiResponse> updateStatus(String id, Map<String, dynamic> data) async {
    final ApiResponse response =
        await ApiHelper.put(ApiEndPoints.updateStatus(id), data);

    if (response.success) {
      return ApiResponse(
          success: true, message: response.message, data: response.data);
    } else {
      return ApiResponse(success: false, message: response.message, data: null);
    }
  }
}
