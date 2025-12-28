import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class CoinFlipper extends StatefulWidget {
  const CoinFlipper({Key? key}) : super(key: key);

  @override
  _CoinFlipperState createState() => _CoinFlipperState();
}

class _CoinFlipperState extends State<CoinFlipper> {
  bool isHeads = true; // Initial state is heads
  bool isLoading = false;

  void flipCoin() {
    setState(() {
      isLoading = true;
    });
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        isHeads = Random().nextBool(); // Randomly change the state to heads or tails
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Flipper'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: isLoading ? null : flipCoin,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      isHeads ? 'assets/heads.jpg' : 'assets/tails.jpg',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  if (isLoading)
                    const CircularProgressIndicator(), // Show loading indicator
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Result: ${isHeads ? 'Heads' : 'Tails'}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : flipCoin,
              child: const Text(
                'Flip Coin',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
