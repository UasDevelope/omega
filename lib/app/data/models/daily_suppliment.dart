class DailyDataSuppliment {
  final bool success;
  final DailyDataContainer data;

  DailyDataSuppliment({
    required this.success,
    required this.data,
  });

  factory DailyDataSuppliment.fromJson(Map<String, dynamic> json) {
    return DailyDataSuppliment(
      success: json['success'],
      data: DailyDataContainer.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data.toJson(),
      };
}

class DailyDataContainer {
  final List<DailyEntry> dailyData;
  final WeekRange weekRange;

  DailyDataContainer({
    required this.dailyData,

    required this.weekRange,
  });

  factory DailyDataContainer.fromJson(Map<String, dynamic> json) {
    return DailyDataContainer(
      dailyData: List<DailyEntry>.from(
        json['dailyData'].map((x) => DailyEntry.fromJson(x)),
      ),
      weekRange: WeekRange.fromJson(json['weekRange']),
    );
  }

  Map<String, dynamic> toJson() => {
        'dailyData': dailyData.map((x) => x.toJson()).toList(),
        'weekRange': weekRange.toJson(),
      };
}

class DailyEntry {
  final String day;
  final String date;
  final int total;
  final int taken;
  final int missed;
  final int adherenceRate;

  DailyEntry({
    required this.day,
    required this.date,
    required this.total,
    required this.taken,
    required this.missed,
    required this.adherenceRate,
  });

  factory DailyEntry.fromJson(Map<String, dynamic> json) {
    return DailyEntry(
      day: json['day'],
      date: json['date'],
      total: (json['total'] as num).toInt(),
      taken: (json['taken'] as num).toInt(),
      missed: (json['missed'] as num).toInt(),
      adherenceRate: (json['adherenceRate'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
        'day': day,
        'date': date,
        'total': total,
        'taken': taken,
        'missed': missed,
        'adherenceRate': adherenceRate,
      };
}

class WeekRange {
  final String start;
  final String end;

  WeekRange({
    required this.start,
    required this.end,
  });

  factory WeekRange.fromJson(Map<String, dynamic> json) {
    return WeekRange(
      start: json['start'],
      end: json['end'],
    );
  }

  Map<String, dynamic> toJson() => {
        'start': start,
        'end': end,
      };
}
