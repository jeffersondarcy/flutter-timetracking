import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/time_trackers_provider.dart';
import 'time_trackers.dart';

class TimerPage extends ConsumerWidget {
  TimerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final trackers = ref.watch(timeTrackersProvider);
    //final toggle = ref.read(timeTrackersProvider.notifier).toggleTimeTracker;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Timers'),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: TimeTrackers(timeTrackers: ref.watch(timeTrackersProvider), toggleTimeTracker: ref.read(timeTrackersProvider.notifier).toggleTimeTracker),
            ),
            CupertinoButton(
              child: Text('Add Timer'),
              onPressed: ref.read(timeTrackersProvider.notifier).addNewTracker,
            ),
          ],
        ),
      ),
    );
  }
}

