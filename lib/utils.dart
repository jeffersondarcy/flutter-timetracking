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