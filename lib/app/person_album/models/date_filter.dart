enum DateFilter { all, today, thisWeek, thisMonth, thisYear }

extension DateFilterX on DateFilter {
  String get label {
    switch (this) {
      case DateFilter.all:
        return "All";
      case DateFilter.today:
        return "Today";
      case DateFilter.thisWeek:
        return "This Week";
      case DateFilter.thisMonth:
        return "This Month";
      case DateFilter.thisYear:
        return "This Year";
    }
  }

  bool matches(DateTime? capturedAt, DateTime now) {
    if (this == DateFilter.all) {
      return true;
    }

    if (capturedAt == null) {
      return false;
    }

    final date = capturedAt.toLocal();

    switch (this) {
      case DateFilter.all:
        return true;
      case DateFilter.today:
        return date.year == now.year &&
            date.month == now.month &&
            date.day == now.day;
      case DateFilter.thisWeek:
        final today = DateTime(now.year, now.month, now.day);
        final start = today.subtract(Duration(days: now.weekday - 1));
        final end = start.add(Duration(days: 7));
        return !date.isBefore(start) && date.isBefore(end);
      case DateFilter.thisMonth:
        return date.year == now.year && date.month == now.month;
      case DateFilter.thisYear:
        return date.year == now.year;
    }
  }
}
