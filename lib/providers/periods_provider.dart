import 'package:flutter_riverpod/flutter_riverpod.dart';
export 'periods_provider.dart';

class Period {
  int startTime;
  int endTime;

  Period({required this.startTime, required this.endTime});
}

class PeriodsNotifier extends FamilyNotifier<List<Period>, String> {
  @override
  build(arg) {
    return [];
  }

  void append(Period period) {
    state = [
      ...state,
      period,
    ];
  }
}

final periodsProvider = NotifierProviderFamily<PeriodsNotifier, List<Period>, String>(PeriodsNotifier.new);