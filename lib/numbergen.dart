import 'dart:math';
import 'package:flutter/material.dart';

class RandomNumberGenerator extends StatefulWidget {
  const RandomNumberGenerator({Key? key}) : super(key: key);

  @override
  _RandomNumberGeneratorState createState() => _RandomNumberGeneratorState();
}

class _RandomNumberGeneratorState extends State<RandomNumberGenerator> {
  int _minValue = 1;
  int _maxValue = 100;
  int _randomNumber = 0;

  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();
  bool _inputError = false;

  @override
  void initState() {
    super.initState();
    _minController.text = _minValue.toString();
    _maxController.text = _maxValue.toString();
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  void _generateRandomNumber() {
    setState(() {
      _inputError = false;
      int? minValue = int.tryParse(_minController.text);
      int? maxValue = int.tryParse(_maxController.text);

      if (minValue != null && maxValue != null && minValue <= maxValue) {
        _minValue = minValue;
        _maxValue = maxValue;
        _randomNumber = Random().nextInt(_maxValue - _minValue + 1) + _minValue;
      } else {
        _inputError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Number Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Random Number: $_randomNumber',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Min:'),
                const SizedBox(width: 10.0),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _minController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 20.0),
                const Text('Max:'),
                const SizedBox(width: 10.0),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _maxController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            if (_inputError)
              const Text(
                'Please enter valid values (Min <= Max)',
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: _generateRandomNumber,
              child: const Text('Generate Random Number')
            ),
          ],
        ),
      ),
    );
  }
}
