import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stopwatch/domain/entities/stopwatch.dart';
import 'package:stopwatch/presentation/view_models/stopwatch_viewmodel.dart';

class StopwatchScreen extends ConsumerStatefulWidget {
  const StopwatchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StopwatchScreenState();
}

class _StopwatchScreenState extends ConsumerState<StopwatchScreen> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: StreamBuilder<StopWatch?>(
            stream: ref.watch(stopwatchViewModelProvider).getStopwatch(),
            builder: (context, stopwatch) {
              //if (!weights.hasData) return const LinearProgressIndicator();
              if (stopwatch.hasData) {
                return Column(
                  children: [
                    Text(
                      "${ref.read(stopwatchViewModelProvider).format(stopwatch.data!.stopwatch.elapsed)}",
                      style: const TextStyle(color: Colors.white, fontSize: 90),
                    ),
                    Expanded(
                      child: ListView.builder(
                        //reverse: true,
                        itemCount: stopwatch.data!.laps.length,
                        itemBuilder: (context, index) {
                          final lap = stopwatch.data!
                              .laps[stopwatch.data!.laps.length - index - 1];
                          return Card(
                            child: ListTile(
                              tileColor: Colors.black87,
                              leading: Text(
                                  "Lap ${(stopwatch.data!.laps.length - index).toString()}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400)),
                              trailing: Text(
                                ref
                                    .read(stopwatchViewModelProvider)
                                    .format(lap.elapsed),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(80),
                      ),
                      onPressed: () {
                        stopwatch.data!.stopwatch.isRunning
                            ? ref.read(stopwatchViewModelProvider).stop()
                            : ref.read(stopwatchViewModelProvider).start();
                      },
                      child: Text(
                          stopwatch.data!.stopwatch.isRunning
                              ? "Stop"
                              : "Start",
                          style: TextStyle(
                              color: stopwatch.data!.stopwatch.isRunning
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 35)),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(30),
                          ),
                          onPressed: () {
                            stopwatch.data!.stopwatch.isRunning
                                ? ref.read(stopwatchViewModelProvider).lap()
                                : ref.read(stopwatchViewModelProvider).reset();
                          },
                          child: Text(
                              stopwatch.data!.stopwatch.isRunning ||
                                      stopwatch.data!.stopwatch.elapsed ==
                                          Duration.zero
                                  ? "Lap"
                                  : "Reset",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 25)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
      ),
    );
  }
}
