/* import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_auth_provider/models/note.dart';
import 'package:supabase_auth_provider/providers/auth_provider.dart';
import 'package:supabase_auth_provider/providers/note_provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final noteController = TextEditingController();

  void addNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New note'),
        content: TextField(controller: noteController),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              noteController.clear();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final note = Note(content: noteController.text);
              context.read<NoteProvider>().insert(note);
              Navigator.pop(context);
              noteController.clear();
            },
            child: Text("Aceptar"),
          ),
        ],
      ),
    );
  }

  void updateNote(int id) async {
    final note = await context.read<NoteProvider>().listById(id);
    if (note != null) {
      noteController.text = note.content;
    } else {
      noteController.text = '';
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update note'),
        content: TextField(controller: noteController),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              noteController.clear();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final note = Note(content: noteController.text,id: id);
              context.read<NoteProvider>().update(note);
              Navigator.pop(context);
              noteController.clear();
            },
            child: Text("Aceptar"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // 🔥 ESTA ES LA LÍNEA QUE TE FALTABA
    Future.microtask(() {
      context.read<NoteProvider>().list();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    final notes = context.watch<NoteProvider>().notes;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notes'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                auth.signOut();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: notes.isEmpty
                ? Text("No hay data")
                : ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.5)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(notes[index].content),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    updateNote(notes[index].id!);
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    print("delete");
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addNote,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
 */