import 'package:intl/intl.dart';

({String dayMonth, String time, bool isTomorrow}) getDateTime(String date) {
  final dt = DateTime.parse(date);

  final month = DateFormat('MMMM').format(dt).toLowerCase();
  final dayMonth = '${dt.day}. $month';

  final time = DateFormat('h:mm a').format(dt);

  final now = DateTime.now();
  final tomorrow = DateTime(now.year, now.month, now.day + 1);
  final dtDateOnly = DateTime(dt.year, dt.month, dt.day);
  final isTomorrow = dtDateOnly == tomorrow;

  return (dayMonth: dayMonth, time: time, isTomorrow: isTomorrow);
}

double getAverageRating(List<String> ratingHistory) {
  if (ratingHistory.isEmpty) return 0.0;

  final sum = ratingHistory
      .map((r) => double.tryParse(r) ?? 0.0)
      .reduce((a, b) => a + b);

  return sum / ratingHistory.length;
}
