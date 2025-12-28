import 'package:flutter/material.dart';

class TicTacToeMenu extends StatelessWidget {
  const TicTacToeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TicTacToeGame();
  }
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({Key? key}) : super(key: key);

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> _gameBoard = List.filled(9, '');
  bool _isXNext = true;
  String _winner = '';
  int _xScore = 0;
  int _oScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildScoreBox('X', _xScore),
                _buildScoreBox('O', _oScore),
              ],
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _onCellTapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(3.0, 3.0),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _gameBoard[index],
                          style: TextStyle(
                              fontSize: 40.0,
                              color: _gameBoard[index] == 'X'
                                  ? Colors.blue
                                  : Colors.red),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _resetGame,
              child: const Text('Reset'),
            ),
            if (_winner.isNotEmpty) // Show winner message
              _buildWinnerPopup(),
          ],
        ),
      ),
    );
  }

  void _onCellTapped(int index) {
    if (_winner.isNotEmpty || _gameBoard[index].isNotEmpty) {
      return; // Game already won or cell already occupied
    }

    setState(() {
      _gameBoard[index] = _isXNext ? 'X' : 'O';
      _isXNext = !_isXNext;
      _checkWinner();
    });
  }

  void _checkWinner() {
    List<List<int>> winningLines = [
      [0, 1, 2], // Horizontal
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6], // Vertical
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8], // Diagonal
      [2, 4, 6],
    ];

    for (var line in winningLines) {
      if (_gameBoard[line[0]] == _gameBoard[line[1]] &&
          _gameBoard[line[1]] == _gameBoard[line[2]] &&
          _gameBoard[line[0]].isNotEmpty) {
        setState(() {
          _winner = _gameBoard[line[0]];
          if (_winner == 'X') {
            _xScore++;
          } else {
            _oScore++;
          }
        });
        _showWinnerPopup();
        return;
      }
    }

    if (_gameBoard.every((cell) => cell.isNotEmpty)) {
      setState(() {
        _winner = 'Draw';
      });
    }
  }

  void _resetGame() {
    setState(() {
      _gameBoard = List.filled(9, '');
      _isXNext = true;
      _winner = '';
    });
  }

  Widget _buildScoreBox(String player, int score) {
    return Column(
      children: [
        Text(
          'Player $player',
          style: const TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        const SizedBox(height: 10.0),
        Text(
          score.toString(),
          style: const TextStyle(fontSize: 24.0, color: Colors.white),
        ),
      ],
    );
  }

  void _showWinnerPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Player $_winner Wins!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildWinnerPopup() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _winner == 'Draw' ? 'It\'s a Draw!' : 'Player $_winner Wins!',
              style: const TextStyle(fontSize: 24.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
