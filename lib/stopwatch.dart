import 'package:flutter/material.dart';

class StopwatchModule extends StatefulWidget {
  const StopwatchModule({Key? key}) : super(key: key);

  @override
  _StopwatchModuleState createState() => _StopwatchModuleState();
}

class _StopwatchModuleState extends State<StopwatchModule> {
  final Stopwatch _stopwatch = Stopwatch();
  String _stopwatchText = '00:00:00';
  final List<String> _lapTimes = [];

  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _updateStopwatch();
    } else {
      _stopwatch.stop();
    }
  }

  void _resetStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    }
    _stopwatch.reset();
    _lapTimes.clear();
    setState(() {
      _stopwatchText = '00:00:00';
    });
  }

  void _lapTime() {
    if (_stopwatch.isRunning) {
      _lapTimes.add(_stopwatchText);
    }
  }

  void _updateStopwatch() {
    if (_stopwatch.isRunning) {
      setState(() {
        _stopwatchText = _formatStopwatchTime(_stopwatch.elapsedMilliseconds);
      });
      Future.delayed(const Duration(milliseconds: 30), _updateStopwatch);
    }
  }

  String _formatStopwatchTime(int milliseconds) {
    int seconds = (milliseconds / 1000).floor();
    int minutes = (seconds / 60).floor();
    int hours = (minutes / 60).floor();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: 15),
            Text(
              _stopwatchText,
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
        
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _startStopwatch,
                  child: Text(
                    _stopwatch.isRunning ? 'Stop' : 'Start',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _lapTime,
                  child: const Text(
                    'Lap',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: const Text(
                    'Reset',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _lapTimes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Lap ${index + 1}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      _lapTimes[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
