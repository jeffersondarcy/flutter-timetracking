import 'package:flutter/cupertino.dart';

import 'widgets/timer_page.dart';


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
