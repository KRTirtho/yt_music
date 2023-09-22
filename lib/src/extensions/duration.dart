extension DurationToHumanReadableString on Duration {
  String toHumanReadableString({padZero = true}) {
    final mm = inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, !padZero && inHours == 0 ? '' : "0");
    final ss = inSeconds.remainder(60).toString().padLeft(2, "0");

    if (inHours > 0) {
      final hh = inHours.toString().padLeft(2, !padZero ? '' : "0");
      return "$hh:$mm:$ss";
    }

    return "$mm:$ss";
  }
}

extension ParseDuration on Duration {
  static Duration fromString(String duration) {
    final parts = duration.split(':').reversed.toList();
    final seconds = int.parse(parts[0]);
    final minutes = parts.length > 1 ? int.parse(parts[1]) : 0;
    final hours = parts.length > 2 ? int.parse(parts[2]) : 0;
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }
}
