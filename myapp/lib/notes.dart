import 'package:flutter/material.dart';
import 'package:myapp/note_model.dart';
import 'package:myapp/noteview.dart';
import 'create_note.dart';  // Import the NoteView class

// Notes Page Widget
class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  _NotesPageState createState() => _NotesPageState();
}

// State class for the Notes Page
class _NotesPageState extends State<NotesPage> {
  List<Note> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              // Navigate to the NoteView page and wait for result
              final updatedNote = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NoteView(
                    note: notes[index],
                    index: index,
                    onNoteDeleted: onNoteDeleted,
                    onNoteUpdated: onNoteUpdated, // Pass the callback function
                  ),
                ),
              );

              // Update the note if it was updated in the NoteView
              if (updatedNote != null) {
                notes[index] = updatedNote;
                setState(() {});
              }
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notes[index].title,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      notes[index].body,
                      style: const TextStyle(fontSize: 20),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateNote(
                onNewNoteCreated: onNewNoteCreated,
              ),
            ),
          );

          // Add the new note if it was created
          if (newNote != null) {
            notes.add(newNote);
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Callback function when a new note is created
  void onNewNoteCreated(Note note) {
    notes.add(note);
    setState(() {});
  }

  // Callback function when a note is deleted
  void onNoteDeleted(int index) {
    notes.removeAt(index);
    setState(() {});
  }

  // Callback function when a note is updated
  void onNoteUpdated(int index, Note updatedNote) {
    notes[index] = updatedNote;
    setState(() {});
  }
}
