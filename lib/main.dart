import 'package:flutter/material.dart';
import 'calculator.dart';
import 'stopwatch.dart';
import 'notes.dart';
import 'clock.dart';
import 'weather.dart';
import 'unitconverter.dart';
import 'qrcode.dart';
//import 'currencyconverter.txt';
import 'randomizer.dart';
import 'translator.dart';
import 'tictactoe.dart';

void main() {
  runApp(UtilVerseApp());
}

class UtilVerseApp extends StatelessWidget {
  const UtilVerseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Util Verse',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UtilVerse',
          textScaleFactor: 1.2,
        ),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2, // Number of columns in the grid
          mainAxisSpacing: 10.0, // Spacing between rows
          crossAxisSpacing: 10.0, // Spacing between columns
          padding: const EdgeInsets.all(20.0),// Padding around the grid
          
          children: <Widget>[
            // --------------- Clock ---------------
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClockModule(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(20.0),
              ),
              child: Image.asset('assets/clock.png',height: 120,width: 120,),
              // child: const Text(
              //   '🕘',
              //   style: TextStyle(fontSize: 80),
              // ),
            ),
            
            // --------------- Calculator ---------------
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalculatorModule(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(20.0),
              ),
              child: Image.asset('assets/calculator.png',height: 120,width: 120,),
              // child: const Text(
              //   '➕|➖\n✖|➗',
              //   style: TextStyle(fontSize: 50, color: Colors.grey),
              //   softWrap: false,
              //   overflow: TextOverflow.ellipsis,
              // ),
              
            ),

            // --------------- Stopwatch ---------------
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StopwatchModule(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(20.0),
              ),
              child: Text(
                '⏳',
                style: TextStyle(fontSize: 0.220 * MediaQuery.of(context).size.width,),
              ),
            ),

            // --------------- Notes ---------------
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotesModule(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(20.0),
              ),
              child: Text(
                '📝',
                style: TextStyle(fontSize: 0.200 * MediaQuery.of(context).size.width,),
              ),
            ),

            // --------------- Weather ---------------
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherModule(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(20.0),
              ),
              //child: Image.asset('assets/weather.png'),
              child:  Text(
                '⛅',
                style: TextStyle(fontSize: 0.250 * MediaQuery.of(context).size.width,),
              ),
            ),

            // --------------- UnitConverter ---------------
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UnitConverter(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(20.0),
              ),
              child: Text(
                '⚖',
                style: TextStyle(fontSize: 0.220 * MediaQuery.of(context).size.width,),
              ),
            ),

            // --------------- QR Code Generator ---------------
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRCodeGenerator(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(20.0),
              ),
              child: Image.asset('assets/qr.png',height: 300,width: 300,),
              // child: const Text(
              //   '⏸',
              //   style: TextStyle(fontSize: 80),
              // ),
            ),

            // --------------- Randomizer ---------------
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Randomizer(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(20.0),
              ),
              child: Image.asset('assets/random.png',height: 120,width: 120,),
              // child: const Text(
              //   '🎲',
              //   style: TextStyle(fontSize: 80),
              // ),
            ),

            // --------------- Translator ---------------
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Translator(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(20.0),
              ),
              child: Image.asset('assets/translator.png',height: 110,width: 110,),
              // child: const Text(
              //   '🔊',
              //   style: TextStyle(fontSize: 50, color: Colors.grey),
              //   softWrap: false,
              //   overflow: TextOverflow.ellipsis,
              // ),
            ),

            // --------------- Tic Tac Toe ---------------
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicTacToeMenu(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(20.0),
              ),
              child: Text(
                '🎮',
                style: TextStyle(fontSize: 0.220 * MediaQuery.of(context).size.width, color: Colors.grey),
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
