import 'package:intl/intl.dart';

mixin TimestampMixin {
  String formatSentTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(
      timestamp.year,
      timestamp.month,
      timestamp.day,
    );
    if (messageDate.isAtSameMomentAs(today)) {
      return 'Sent at ${DateFormat('h:mma').format(timestamp)}';
    } else if (messageDate.isAtSameMomentAs(
      today.subtract(Duration(days: 1)),
    )) {
      return 'Yesterday at ${DateFormat('h:mm a').format(timestamp)}';
    } else {
      return DateFormat('MMM d, yyyy h:mm a').format(timestamp);
    }
  }
}
