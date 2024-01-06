import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stopwatch/domain/entities/lap.dart';
import 'package:stopwatch/domain/entities/stopwatch.dart';
import 'package:stopwatch/domain/usecases/stopwatch_usecases/save_stopwatch_usecase.dart';
import 'package:stopwatch/injector.dart';

final loaderStateProvider = StateProvider<bool>((ref) => false);

final stopwatchProvider = StateProvider<StopWatch?>((ref) => null);

final stopwatchViewModelProvider =
    Provider.autoDispose<StopwatchScreenViewModel>(
  (ref) => StopwatchScreenViewModel(ref,
      saveStopWatchUsecase: Injector.saveStopwatchUsecase),
);

class StopwatchScreenViewModel {
  late ProviderRef ref;
  late SaveStopWatchUsecase saveStopWatchUsecase;
  static final StopwatchScreenViewModel _singleton =
      StopwatchScreenViewModel._internal();

  factory StopwatchScreenViewModel(ProviderRef reference,
      {required SaveStopWatchUsecase saveStopWatchUsecase}) {
    _singleton.ref = reference;
    _singleton.saveStopWatchUsecase = saveStopWatchUsecase;
    _singleton.stream = _singleton.controller.stream.asBroadcastStream();

    Timer.periodic(const Duration(milliseconds: 100), ((timer) {
      _singleton.controller.sink.add(_singleton.stopWatch);
    }));

    return _singleton;
  }

  StopwatchScreenViewModel._internal();

  StreamController<StopWatch> controller = StreamController<StopWatch>();
  late Stream<StopWatch> stream;
  StopWatch stopWatch = StopWatch(
      stopwatch: Stopwatch(),
      laps: List<Lap>.empty(growable: true),
      lapsCumulative: Duration.zero);

  void saveStopwatch(StopWatch stopWatch) {
    try {
      saveStopWatchUsecase.execute(SaveStopWatchParams(stopWatch: stopWatch));
    } catch (e) {
      ref.read(loaderStateProvider.notifier).state = false;
    }
  }

  String format(Duration d) => d.toString().substring(2, 10);

  void start() {
    stopWatch.stopwatch.start();
  }

  void stop() {
    stopWatch.stopwatch.stop();
  }

  void reset() {
    stopWatch.stopwatch.reset();
    stopWatch.laps.clear();
    stopWatch.lapsCumulative = Duration.zero;
  }

  void lap() {
    Duration newLap = stopWatch.stopwatch.elapsed - stopWatch.lapsCumulative;
    stopWatch.laps.insert(stopWatch.laps.length, Lap(elapsed: newLap));
    stopWatch.lapsCumulative += newLap;
  }

  Stream<StopWatch?> getStopwatch() {
    return stream;
  }
}
