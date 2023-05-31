import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterone/providers/periods_provider.dart';
import 'package:uuid/uuid.dart';

class TimeTracker {
  final String id;
  String name;
  int? runningStartTime;
  int totalTimeAccumulated;
  bool get isRunning => runningStartTime != null;

  TimeTracker({String? id, this.name = '', this.totalTimeAccumulated = 0})
      : this.id = id ?? Uuid().v4();
}

class TimeTrackerNotifier extends Notifier<Map<String, TimeTracker>> {
  @override
  Map<String, TimeTracker> build() {
    return {};
  }

  void addNewTracker() {
    final newTracker = TimeTracker();
    state = {...state, newTracker.id: newTracker};
  }

  void deleteTracker(String id) {
    state = {...state}..remove(id);
  }

  void toggleTimeTracker(String id) {
    final tracker = state[id]!;
    if (tracker.isRunning) {
      stopTimer(id);
    } else {
      startTimer(id);
    }
  }

  void startTimer(String id) {
    final tracker = state[id]!;
    if (!tracker.isRunning) {
      tracker.runningStartTime = DateTime.now().millisecondsSinceEpoch;
    }
  }

  void stopTimer(String id) {
    final tracker = state[id]!;

    if (tracker.isRunning) {
      final startTime = state[id]!.runningStartTime!;
      final endTime = DateTime.now().millisecondsSinceEpoch;

      ref.read(periodsProvider(id).notifier).append(Period(
      startTime: startTime,
      endTime: endTime,
    ));

      final totalTimeAccomulated = tracker.totalTimeAccumulated + DateTime.now().millisecondsSinceEpoch - tracker.runningStartTime!;
      tracker.runningStartTime = null;

      state = {
        ...state,
        id:TimeTracker(
          id: id,
          name: tracker.name,
          totalTimeAccumulated: totalTimeAccomulated,
        )
      };
    }
  }

}

final timeTrackersProvider = NotifierProvider<TimeTrackerNotifier, Map<String, TimeTracker>>(TimeTrackerNotifier.new);
