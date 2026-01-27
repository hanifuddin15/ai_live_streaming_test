import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String get capitalizeFirst {
    if (isEmpty) return '';
    return this[0].toUpperCase() + substring(1);
  }
  
}
extension TimeStringExtensions on String {
  /// Converts a 12-hour time string like '2:30 PM' → 24-hour formatted string '14:30'
  String to24HourFormat() {
    try {
      // Use DateFormat for robust parsing of 12-hour format time.
      final time = DateFormat.jm().parseLoose(this);
      // Format it into 24-hour format with seconds.
      return DateFormat('HH:mm:ss').format(time);
    } catch (e) {
      debugPrint('Error converting to 24-hour format for "$this": $e');
      // Return a default or rethrow, depending on desired error handling.
      return '00:00:00';
    }
  }

  /// Converts a 24-hour time string like '14:30' → 12-hour formatted string '2:30 PM'
  String to12HourFormat() {
    // If the string already contains AM or PM, assume it's formatted.
    if (toUpperCase().contains('AM') || toUpperCase().contains('PM')) {
      return this;
    }

    try {
      final parts = split(':');
      if (parts.length < 2) {
        return this; // Not a valid time format we can convert.
      }

      int hour = int.parse(parts[0]);
      final int minute = int.parse(
        parts[1].split(' ')[0],
      ); // Handle cases like "14:30:00"
      final period = hour >= 12 ? 'PM' : 'AM';
      hour = hour % 12;
      if (hour == 0) hour = 12;

      return '$hour:${minute.toString().padLeft(2, '0')} $period';
    } catch (e) {
      return this; // Return original string if parsing fails
    }
  }
}

extension StringDateExtensions on String? {
  String toFormatDateAndMonthInWords() {
    try {
      if (this == null || this!.isEmpty) return '';

      String dateStr = this!.trim();
      DateTime dt;

      // Try parsing US-style (MM/dd/yyyy HH:mm:ss)
      try {
        dt = DateFormat('MM/dd/yyyy HH:mm:ss').parse(dateStr);
      } catch (_) {
        // If fails, try parsing EU-style (dd/MM/yyyy)
        dt = DateFormat('dd/MM/yyyy').parse(dateStr);
      }

      // Output format: Oct 30, 2025
      return DateFormat('MMM dd, yyyy').format(dt);
    } catch (e) {
      return '';
    }
  }

  String toWorkPlaceDuration() {
    try {
      final dt = DateTime.parse(this ?? '');
      return DateFormat('yyyy MMMM').format(dt);
    } catch (e) {
      return '';
    }
  }

  String toFormatToReadableDate() {
    try {
      final dateTime = DateTime.parse(this ?? '');
      return DateFormat('MMM d, yyyy h:mm a').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  String toDetailFormatDateTime() {
    try {
      final dt = DateTime.parse(this ?? '');
      final formatted = DateFormat('EEE, MMM d, y h:mm a').format(dt);
      debugPrint('Formatted Date: $formatted');
      return formatted;
    } catch (e) {
      debugPrint('Error parsing date: $e');
      return '';
    }
  }

  // String toWordlyTimeText() {
  //   try {
  //     DateTime postDateTime = DateTime.parse(this!).toLocal();
  //     DateTime currentDatetime = DateTime.now();
  //     int millisecondsDifference =
  //         currentDatetime.millisecondsSinceEpoch -
  //         postDateTime.millisecondsSinceEpoch;
  //     int minutesDifference =
  //         (millisecondsDifference / Duration.millisecondsPerMinute).truncate();

  //     if (minutesDifference < 1) {
  //       return 'a few seconds ago';
  //     } else if (minutesDifference < 30) {
  //       return '$minutesDifference minutes ago';
  //     } else if (DateUtils.isSameDay(postDateTime, currentDatetime)) {
  //       return 'Today at ${postTimeFormat.format(postDateTime)}';
  //     } else {
  //       return postDateTimeFormat.format(postDateTime);
  //     }
  //   } catch (e) {
  //     return '';
  //   }
  // }

  String toFormatInvoiceNumber() {
    if (this == null) return 'No Id';
    final parts = this!.split('-');
    if (parts.length >= 5) {
      return '${parts[0]}-${parts[1]}-${parts[4]}';
    }
    return this!;
  }

  String toFormatDateAndTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return DateFormat('MMMM d, yyyy h:mm a').format(dateTime);
  }
}
