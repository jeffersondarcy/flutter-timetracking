import 'providers/time_trackers_provider.dart';

export 'utils.dart';

String millisecondsToFormattedTime(int milliseconds) {
  Duration duration = Duration(milliseconds: milliseconds);
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  String formattedTime = "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  return formattedTime;
}

int calculateTotalTime(TimeTracker timeTracker) {
  if (timeTracker.isRunning) {
    return timeTracker.totalTimeAccumulated + DateTime.now().millisecondsSinceEpoch - timeTracker.runningStartTime!;
  } else {
    return timeTracker.totalTimeAccumulated;
  }
}

Map<String, int> getTimersTotalTimes(Map<String, TimeTracker> timeTrackers) {
  Map<String, int> totalTimes = {};
  timeTrackers.forEach((id, timeTracker) {
    totalTimes[id] = calculateTotalTime(timeTracker);
  });
  return totalTimes;
}