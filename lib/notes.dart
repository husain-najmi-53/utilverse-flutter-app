import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class NotesModule extends StatefulWidget {
  const NotesModule({Key? key}) : super(key: key);

  @override
  _NotesModuleState createState() => _NotesModuleState();
}

class _NotesModuleState extends State<NotesModule> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  List<Note> notes = [];
  late SharedPreferences prefs;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  _loadNotes() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? notesList = prefs.getStringList('notes');
    if (notesList != null) {
      setState(() {
        notes = notesList.map((json) => Note.fromJson(json)).toList();
      });
    }
  }

  _saveNotes() async {
    List<String> notesList = notes.map((note) => note.toJson()).toList();
    await prefs.setStringList('notes', notesList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _showNoteDialog();
              },
              child: Text(isEditing ? 'Edit Note' : 'Add Note',textScaleFactor:1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Notes:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return _buildNoteCard(notes[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteCard(Note note) {
    return Card(
      margin: const EdgeInsets.all(10),
      shadowColor: Colors.deepPurple,
      child: InkWell(
        onTap: () {
          _showNoteDialog(note: note);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(note.content),
              OverflowBar(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteNote(note);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _showNoteDialog(note: note);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNoteDialog({Note? note}) {
  titleController.text = note?.title ?? '';
  contentController.text = note?.content ?? '';
  isEditing = note != null;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(isEditing ? 'Edit Note' : 'Add Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Note Title',
              ),
            ),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Note Content',
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _saveNote(note);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}


  void _saveNote(Note? note) {
    String title = titleController.text.trim();
    String content = contentController.text.trim();

    if (title.isNotEmpty && content.isNotEmpty) {
      setState(() {
        if (isEditing) {
          note!.title = title;
          note.content = content;
        } else {
          notes.add(Note(title: title, content: content));
        }
        titleController.clear();
        contentController.clear();
        isEditing = false;
        _saveNotes();
      });
    }
  }

  void _deleteNote(Note note) {
    setState(() {
      notes.remove(note);
      _saveNotes();
    });
  }
}

class Note {
  String title;
  String content;

  Note({
    required this.title,
    required this.content,
  });

  factory Note.fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);
    return Note(
      title: data['title'],
      content: data['content'],
    );
  }

  String toJson() {
    return jsonEncode({
      'title': title,
      'content': content,
    });
  }
}
