enum PersonPhotoDateFilter { all, today, thisWeek, thisMonth, thisYear }

extension PersonPhotoDateFilterX on PersonPhotoDateFilter {
  String get label {
    switch (this) {
      case PersonPhotoDateFilter.all:
        return "All";
      case PersonPhotoDateFilter.today:
        return "Today";
      case PersonPhotoDateFilter.thisWeek:
        return "This Week";
      case PersonPhotoDateFilter.thisMonth:
        return "This Month";
      case PersonPhotoDateFilter.thisYear:
        return "This Year";
    }
  }

  bool matches(DateTime dateTime, DateTime now) {
    switch (this) {
      case PersonPhotoDateFilter.all:
        return true;
      case PersonPhotoDateFilter.today:
        return dateTime.year == now.year &&
            dateTime.month == now.month &&
            dateTime.day == now.day;
      case PersonPhotoDateFilter.thisWeek:
        final startOfWeek = DateTime(
          now.year,
          now.month,
          now.day,
        ).subtract(Duration(days: now.weekday - 1));
        final endOfWeek = startOfWeek.add(Duration(days: 7));
        return !dateTime.isBefore(startOfWeek) && dateTime.isBefore(endOfWeek);
      case PersonPhotoDateFilter.thisMonth:
        return dateTime.year == now.year && dateTime.month == now.month;
      case PersonPhotoDateFilter.thisYear:
        return dateTime.year == now.year;
    }
  }
}
