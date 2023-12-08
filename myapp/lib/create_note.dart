import 'package:flutter/material.dart';
import 'package:myapp/note_model.dart';

// CreateNote Widget for creating new notes
class CreateNote extends StatefulWidget {
  const CreateNote({super.key, required this.onNewNoteCreated});

  final Function(Note) onNewNoteCreated;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

// State class for the CreateNote Widget
class _CreateNoteState extends State<CreateNote> {
  final titleController = TextEditingController(); // Controller for the note title
  final bodyController = TextEditingController(); // Controller for the note body
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'create notes',
            style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(
                fontSize: 28
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Title"
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: bodyController,
              style: const TextStyle(
                fontSize: 18
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "your Story"
              )
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            if(titleController.text.isEmpty){
              return; // Do nothing if title or body is empty
            }
            if(bodyController.text.isEmpty){
              return;
            }
            // Create a new Note object
            final note = Note(
              body: bodyController.text,
              title: titleController.text,
            );

            // Call the callback function to inform the parent widget about the new note
            widget.onNewNoteCreated(note);
            Navigator.of(context).pop(); // Close the CreateNote page
        },
        child:const Icon(
            Icons.save,
        ),
      ),
    );
  }
}
