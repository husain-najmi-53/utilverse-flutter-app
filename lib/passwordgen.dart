import 'dart:math';
import 'package:flutter/material.dart';

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({Key? key}) : super(key: key);

  @override
  _PasswordGeneratorPageState createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGenerator> {
  bool includeUppercase = true;
  bool includeLowercase = true;
  bool includeNumbers = true;
  bool includeSpecialCharacters = true;
  int passwordLength = 0;
  String generatedPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Password Generator'),
      ),
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Password Length:',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter length',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  passwordLength = int.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20.0),
            CheckboxListTile(
              title: const Text('Include Uppercase Letters'),
              value: includeUppercase,
              onChanged: (value) {
                setState(() {
                  includeUppercase = value ?? true;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Include Lowercase Letters'),
              value: includeLowercase,
              onChanged: (value) {
                setState(() {
                  includeLowercase = value ?? true;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Include Numbers'),
              value: includeNumbers,
              onChanged: (value) {
                setState(() {
                  includeNumbers = value ?? true;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Include Special Characters'),
              value: includeSpecialCharacters,
              onChanged: (value) {
                setState(() {
                  includeSpecialCharacters = value ?? true;
                });
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                generatePassword();
              },
              child: const Text('Generate Password'),
            ),
            const SizedBox(height: 20.0),
            if (generatedPassword.isNotEmpty) ...[
              const Text(
                'Generated Password:',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(88, 20, 143, 1)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: SelectableText(
                  generatedPassword,
                  style: const TextStyle(fontSize: 24.0),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void generatePassword() {
    if (passwordLength <= 0) {
      setState(() {
        generatedPassword = 'Password length must be greater than zero!';
      });
      return;
    }

    String uppercaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String lowercaseLetters = 'abcdefghijklmnopqrstuvwxyz';
    String numbers = '0123456789';
    String specialCharacters = '!@#\$%&*()_[]';

    String allowedCharacters = '';
    if (includeUppercase) allowedCharacters += uppercaseLetters;
    if (includeLowercase) allowedCharacters += lowercaseLetters;
    if (includeNumbers) allowedCharacters += numbers;
    if (includeSpecialCharacters) allowedCharacters += specialCharacters;

    if (allowedCharacters.isEmpty) {
      setState(() {
        generatedPassword = 'No characters selected!';
      });
      return;
    }

    String password = '';
    Random random = Random();
    for (int i = 0; i < passwordLength; i++) {
      int randomIndex = random.nextInt(allowedCharacters.length);
      password += allowedCharacters[randomIndex];
    }

    setState(() {
      generatedPassword = password;
    });
  }
}
