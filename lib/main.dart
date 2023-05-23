import 'package:flutter/cupertino.dart';
import 'dart:async' as async;
import 'timer.dart';
import 'utils.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final Timers _timers = Timers();
  late Map<String, int> _timerTotalTimes;

  late async.Timer _pageUpdateTimer;

  @override
  void initState() {
    _timerTotalTimes = getTimersTotalTimes(_timers);
    super.initState();
    _pageUpdateTimer = async.Timer.periodic(const Duration(seconds: 1), (async.Timer t) => setState(() { _timerTotalTimes = getTimersTotalTimes(_timers);}));
  }

  @override
  void dispose() {
    _pageUpdateTimer.cancel();  // updated reference
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Timers'),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _timers.timers.length,
                itemBuilder: (context, index) {
                  String id = _timers.timers.keys.elementAt(index);
                  Timer timer = _timers.timers[id]!;
                  return CupertinoListTile(
                    title: Text("Timer ${index + 1}"),
                    subtitle: Text("Total Time: ${millisecondsToFormattedTime(_timerTotalTimes[id]!)}"),
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
              ),
            ),
            CupertinoButton(
              child: Text('Add Timer'),
              onPressed: () {
                setState(() {
                  _timers.addTimer();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

