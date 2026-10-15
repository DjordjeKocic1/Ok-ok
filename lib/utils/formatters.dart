import 'package:intl/intl.dart';

({String dayMonth, String time, bool isTomorrow, String year}) getDateTime(
  String date,
) {
  final dt = DateTime.parse(date);

  final month = DateFormat('MMMM').format(dt).toLowerCase();
  final year = DateFormat('yyyy').format(dt);
  final dayMonth = '${dt.day}. $month';

  final time = DateFormat('HH:mm').format(dt);

  final now = DateTime.now();
  final tomorrow = DateTime(now.year, now.month, now.day + 1);
  final dtDateOnly = DateTime(dt.year, dt.month, dt.day);
  final isTomorrow = dtDateOnly == tomorrow;

  return (dayMonth: dayMonth, time: time, isTomorrow: isTomorrow, year: year);
}

String formatDate(String isoString, {String? format = 'dd.MM.yyyy.'}) {
  final date = DateTime.parse(isoString).toLocal();
  return DateFormat(format).format(date);
}

String initial(String? text) {
  if (text == null) return '';
  final trimmed = text.trim();
  if (trimmed.isEmpty) return '';
  return '${trimmed[0].toUpperCase()}.';
}
