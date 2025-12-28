import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';

enum Language {
  English,
  Russian,
  Italian,
  Chinese,
  Hindi,
  Marathi,
  Telugu,
  Gujarati,
  Arabic,
  Urdu,
  French,
  German,
}

class Translator extends StatefulWidget {
  const Translator({Key? key}) : super(key: key);

  @override
  _TranslatorPageState createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<Translator> {
  final translator = GoogleTranslator();

  Language selectedLanguageFrom = Language.English;
  Language selectedLanguageTo = Language.Hindi;

  String inputText = '';
  String translatedText = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<Language>(
                    style: const TextStyle(fontSize: 16,color: Color.fromRGBO(88, 20, 143, 1)),
                    value: selectedLanguageFrom,
                    onChanged: (Language? newValue) {
                      setState(() {
                        selectedLanguageFrom = newValue!;
                      });
                    },
                    items: Language.values.map((lang) {
                      return DropdownMenuItem<Language>(
                        value: lang,
                        child: Text(lang.toString().split('.').last),
                      );
                    }).toList(),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.swap_horiz,
                    color: Color.fromRGBO(88, 20, 143, 1),
                  ),
                  onPressed: () {
                    setState(() {
                      final temp = selectedLanguageFrom;
                      selectedLanguageFrom = selectedLanguageTo;
                      selectedLanguageTo = temp;
                    });
                  },
                ),
                Expanded(
                  child: DropdownButton<Language>(
                    style: const TextStyle(fontSize: 16,color: Color.fromRGBO(88, 20, 143, 1)),
                    value: selectedLanguageTo,
                    onChanged: (Language? newValue) {
                      setState(() {
                        selectedLanguageTo = newValue!;
                      });
                    },
                    items: Language.values.map((lang) {
                      return DropdownMenuItem<Language>(
                        value: lang,
                        child: Text(lang.toString().split('.').last),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter text to translate';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    inputText = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Enter text to translate',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(88, 20, 143, 1),
                  foregroundColor: Colors.white),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  translateText();
                }
              },
              child: const Text('Translate'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Translated Text:',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        translatedText,
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.copy,
                              color: Color.fromRGBO(88, 20, 143, 1),
                            ),
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: translatedText));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Copied to Clipboard')),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> translateText() async {
    try {
      final translation = await translator.translate(
        inputText,
        from: _languageCode(selectedLanguageFrom),
        to: _languageCode(selectedLanguageTo),
      );
      setState(() {
        translatedText = translation.toString();
      });
    } catch (e) {
      //print('Translation error: $e');
    }
  }

  String _languageCode(Language language) {
    switch (language) {
      case Language.English:
        return 'en';
      case Language.Russian:
        return 'ru';
      case Language.Italian:
        return 'it';
      case Language.Chinese:
        return 'zh-cn';
      case Language.Hindi:
        return 'hi';
      case Language.Marathi:
        return 'mr';
      case Language.Telugu:
        return 'te';
      case Language.Gujarati:
        return 'gu';
      case Language.Arabic:
        return 'ar';
      case Language.Urdu:
        return 'ur';
      case Language.French:
        return 'fr';
      case Language.German:
        return 'de';
      default:
        return 'en';
    }
  }
}
