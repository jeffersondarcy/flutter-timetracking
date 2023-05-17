import 'package:flutter/cupertino.dart';
import 'timer.dart';

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
                    subtitle: Text("Total Time: ${timer.totalTimeAccumulated}"),
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

