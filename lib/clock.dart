import 'dart:async';
import 'package:flutter/material.dart';

class ClockModule extends StatefulWidget {
  const ClockModule({Key? key}) : super(key: key);

  @override
  _ClockModuleState createState() => _ClockModuleState();
}

class _ClockModuleState extends State<ClockModule> {
  DateTime _dateTime = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _dateTime = DateTime.now();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var hr = _dateTime.hour;
    var min = _dateTime.minute;
    var sec = _dateTime.second;
    var session = "AM";

    if (hr == 0) {
      hr = 12;
    }
    if (hr > 12) {
      hr = hr - 12;
      session = "PM";
    }

    var hrStr = (hr < 10) ? "0$hr" : hr.toString();
    var minStr = (min < 10) ? "0$min" : min.toString();
    var secStr = (sec < 10) ? "0$sec" : sec.toString();

    var time = "$hrStr:$minStr:$secStr";
    var date = _dateTime.toLocal().toString().split(' ')[0];

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Clock',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(88, 20, 143, 1)),
      backgroundColor: const Color.fromRGBO(88, 20, 143, 1.00),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 72,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              session,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              date,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
