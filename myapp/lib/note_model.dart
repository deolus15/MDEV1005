class Note{
   String title;
   String body;

   // Constructor
  Note({
    required this.title,
    required this.body
  });

   // Copy constructor
   Note.copy(Note other)
       : title = other.title,
         body = other.body;

   // CopyWith method
   Note copyWith({
     String? title,
     String? body,
   }) {
     return Note(
       title: title ?? this.title,
       body: body ?? this.body,
     );
   }
}