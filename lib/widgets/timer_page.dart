import 'package:flutter/cupertino.dart';
import 'timers_list.dart';
import '../timer.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final Timers _timers = Timers();

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
              child: TimersList(_timers),
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

