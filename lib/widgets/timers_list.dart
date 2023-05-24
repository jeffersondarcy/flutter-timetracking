import 'package:flutter/cupertino.dart';
import 'dart:async' as async;
import '../timer.dart';
import '../utils.dart';

export 'timers_list.dart' show TimersList;
class TimersList extends StatefulWidget {
  final Timers timers;

  TimersList(this.timers);

  @override
  _TimersListState createState() => _TimersListState();
}

class _TimersListState extends State<TimersList> {
  late async.Timer _updateTimer;
  late Map<String, int> _timerTotalTimes;

  @override
  void initState() {
    super.initState();
    _timerTotalTimes = getTimersTotalTimes(widget.timers);
    _updateTimer = async.Timer.periodic(const Duration(seconds: 1), (timer) => setState(() {_timerTotalTimes = getTimersTotalTimes(widget.timers);}));
  }

  @override
  void dispose() {
    _updateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.timers.timers.length,
      itemBuilder: (context, index) {
        String id = widget.timers.timers.keys.elementAt(index);
        Timer timer = widget.timers.timers[id]!;
        return CupertinoListTile(
          title: Text("Timer ${index + 1}"),
          subtitle: Text("Total Time: ${millisecondsToFormattedTime(_timerTotalTimes[id] ?? 0)}"),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                toggleTimer(timer);
              });
            },
            child: Icon(timer.isRunning ? CupertinoIcons.pause_solid : CupertinoIcons.play_arrow_solid, size: 24),
          ),
        );
      },
    );
  }
}