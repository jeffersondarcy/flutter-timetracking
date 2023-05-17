import 'package:uuid/uuid.dart';

export 'timer.dart' show Timers;

class Period {
  int startTime;
  int? endTime;

  Period() : startTime = DateTime.now().millisecondsSinceEpoch;
}

class Timer {
  bool isRunning = false;
  List<Period> periods = [];
  int totalTimeAccumulated = 0;
}

void startTimer(Timer timer) {
  if (!timer.isRunning) {
    timer.periods.add(Period());
    timer.isRunning = true;
  }
}

void stopTimer(Timer timer) {
  if (timer.isRunning) {
    timer.periods.last.endTime = DateTime.now().millisecondsSinceEpoch;
    timer.totalTimeAccumulated += timer.periods.last.endTime! - timer.periods.last.startTime;
    timer.isRunning = false;
  }
}

int calculateTotalTime(Timer timer) {
  if (timer.isRunning) {
    return timer.totalTimeAccumulated + DateTime.now().millisecondsSinceEpoch - timer.periods.last.startTime;
  } else {
    return timer.totalTimeAccumulated;
  }
}

class Timers {
  final Map<String, Timer> timers = {};

  void addTimer() {
    String id = Uuid().v4();
    timers[id] = Timer();
  }

  void removeTimer(String id) {
    timers.remove(id);
  }
}

