import '../models/duration_time.dart';

final List<DurationTime> durationTimes = [
  DurationTime(key: "one_day"),
  DurationTime(key: "three_days"),
  DurationTime(key: "one_week"),
  DurationTime(key: "two_weeks"),
  DurationTime(key: "one_month"),
];

final Map<String, DurationTime> durationTimesMap = {
  for (var duration in durationTimes) duration.key: duration
};
