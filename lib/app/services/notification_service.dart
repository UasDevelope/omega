import 'package:omega/app/data/api/api_helper.dart';
import 'package:omega/app/data/api/end_points.dart';

class NotificationService {
  static Future<dynamic> fetchNotifications() async {
    final response = await ApiHelper.get(ApiEndPoints.notification);
    return response;
  }
}
