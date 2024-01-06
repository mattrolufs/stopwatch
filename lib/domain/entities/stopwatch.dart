import 'dart:core';

import 'package:stopwatch/domain/entities/lap.dart';

class StopWatch {
  StopWatch(
      {required this.stopwatch,
      required this.laps,
      required this.lapsCumulative});

  final Stopwatch stopwatch;
  final List<Lap> laps;
  Duration lapsCumulative;
}
