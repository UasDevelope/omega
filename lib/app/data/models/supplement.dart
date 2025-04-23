class SupplementModel {
  final String id;
  final String name;
  final String form;
  final String reason;
  final int day;
  final String time;
   String status;
  final String? lastStatusUpdate;
  final String user;
  final Schedule schedule;
  final DateTime createdAt;

  SupplementModel({
    required this.id,
    required this.name,
    required this.form,
    required this.reason,
    required this.day,
    required this.time,
    required this.status,
    this.lastStatusUpdate,
    required this.user,
    required this.schedule,
    required this.createdAt,
  });

  factory SupplementModel.fromJson(Map<String, dynamic> json) {
    return SupplementModel(
      id: json['_id'],
      name: json['name'],
      form: json['form'],
      reason: json['reason'],
      day: json['day'],
      time: json['time'],
      status: json['status'],
      lastStatusUpdate: json['lastStatusUpdate'],
      user: json['user'],
      schedule: Schedule.fromJson(json['schedule']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'form': form,
      'reason': reason,
      'day': day,
      'time': time,
      'status': status,
      'lastStatusUpdate': lastStatusUpdate,
      'user': user,
      'schedule': schedule.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class Schedule {
  final String? startDate;
  final String? endDate;

  Schedule({
    this.startDate,
    this.endDate,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}
