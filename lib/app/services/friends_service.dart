import '../data/api/api_helper.dart';
import '../data/api/end_points.dart';

class FriendsService {
  static Future<dynamic> shareDiary(Map<String, dynamic> data) async {
    final response = await ApiHelper.post(ApiEndPoints.shareDiary, data);
    return response;
  }

  static Future<dynamic> inviteFriends(Map<String, dynamic> data) async {
    final response = await ApiHelper.post(ApiEndPoints.invite, data);
    return response;
  }
}
