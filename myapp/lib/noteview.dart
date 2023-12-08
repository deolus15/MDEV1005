import 'package:flutter/material.dart';
import 'package:myapp/note_model.dart';
import 'note_model.dart';

// NoteView Widget for displaying and editing the details of a single note
class NoteView extends StatefulWidget {
  const NoteView({
    Key? key,
    required this.note,
    required this.onNoteDeleted,
    required this.onNoteUpdated, // Add this line
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;
  final Function(int) onNoteDeleted;
  final Function(int, Note) onNoteUpdated; // Add this line

  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _bodyController = TextEditingController(text: widget.note.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note View"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              _showDeleteDialog();
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              _saveChanges();
            },
            icon: const Icon(
                Icons.save,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              style: const TextStyle(fontSize: 26),
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _bodyController,
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                hintText: 'Body',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    final updatedNote = widget.note.copyWith(
      title: _titleController.text,
      body: _bodyController.text,
    );
    widget.onNoteUpdated(widget.index, updatedNote);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note updated')),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete This?"),
          content: Text("Note ${widget.note.title} will be deleted!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onNoteDeleted(widget.index);
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
