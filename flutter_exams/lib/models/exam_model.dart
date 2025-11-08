class Exam {
  String subject;
  DateTime dateTime;
  List<String> rooms;

  Exam({
    required this.subject,
    required this.dateTime,
    required this.rooms,
  });

  bool get isPast {
    return dateTime.isBefore(DateTime.now());
  }

  String get formattedDate {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;
    return '$day.$month.$year';
  }

  String get formattedTime {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String get formattedRooms {
    return rooms.join(', ');
  }

  String getTimeRemaining() {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if (isPast) {
      final pastDifference = now.difference(dateTime);
      final days = pastDifference.inDays;
      final hours = pastDifference.inHours % 24;

      if (days > 0) {
        return 'Завршен пред $days дена, $hours часа';
      } else if (hours > 0) {
        return 'Завршен пред $hours часа';
      } else {
        return 'Завршен денес';
      }
    }

  
    final days = difference.inDays;
    final hours = difference.inHours % 24;

    if (days > 0) {
      return '$days дена, $hours часа';
    } else if (hours > 0) {
      return '$hours часа';
    } else {
      return 'Наскоро!';
    }
  }
}