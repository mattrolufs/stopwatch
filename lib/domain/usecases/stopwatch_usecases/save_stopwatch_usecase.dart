import 'package:stopwatch/domain/entities/stopwatch.dart';

import '../base_usecase.dart';

class SaveStopWatchUsecase extends BaseUseCase<void, SaveStopWatchParams> {
  SaveStopWatchUsecase();

  @override
  void execute(SaveStopWatchParams params) {}
}

class SaveStopWatchParams {
  SaveStopWatchParams({required this.stopWatch}) : super();

  final StopWatch stopWatch;
}
