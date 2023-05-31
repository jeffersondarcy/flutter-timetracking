import 'dart:async' as async;
import 'package:flutter/cupertino.dart';
import '../providers/time_trackers_provider.dart';
import '../utils.dart';

export 'time_trackers.dart' show TimeTrackers;
class TimeTrackers extends StatefulWidget {
  final Map<String, TimeTracker> timeTrackers;
  final void Function(String) toggleTimeTracker;

  TimeTrackers({required this.timeTrackers, required this.toggleTimeTracker});

  @override
  _TimeTrackersState createState() => _TimeTrackersState();
}

class _TimeTrackersState extends State<TimeTrackers> {
  late async.Timer _updateTimer;
  late Map<String, int> _timerTotalTimes;

  @override
  void initState() {
    super.initState();
    _timerTotalTimes = getTimersTotalTimes(widget.timeTrackers);
    _updateTimer = async.Timer.periodic(const Duration(seconds: 1), (timer) => setState(() {_timerTotalTimes = getTimersTotalTimes(widget.timeTrackers);}));
  }

  @override
  void dispose() {
    _updateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.timeTrackers.length,
      itemBuilder: (context, index) {
        String id = widget.timeTrackers.keys.elementAt(index);
        TimeTracker timeTracker = widget.timeTrackers[id]!;
        return CupertinoListTile(
          title: Text("Timer ${index + 1}"),
          subtitle: Text("Total Time: ${millisecondsToFormattedTime(_timerTotalTimes[id] ?? 0)}"),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
                widget.toggleTimeTracker(id);
            },
            child: Icon(timeTracker.isRunning ? CupertinoIcons.pause_solid : CupertinoIcons.play_arrow_solid, size: 24),
          ),
        );
      },
    );
  }
}