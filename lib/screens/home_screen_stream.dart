import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_auth_provider/models/note.dart';
import 'package:supabase_auth_provider/providers/auth_provider.dart';
import 'package:supabase_auth_provider/providers/note_provider_stream.dart';

class HomeScreenStream extends StatefulWidget {
  const HomeScreenStream({super.key});

  @override
  State<HomeScreenStream> createState() => _HomeScreenStreamState();
}

class _HomeScreenStreamState extends State<HomeScreenStream> {
  bool isEditing = false;
  final noteController = TextEditingController();
  void submit([Note? nota]) {
    final currentUserId = context.read<AuthProvider>().session?.user.id;
    if (currentUserId == null) {
      return;
    }

    // update editing flag so the dialog updates correctly
    setState(() {
      isEditing = nota != null;
      if (isEditing) noteController.text = nota!.content;
    });

    showDialog(
      context: context,
      builder: (builder) => AlertDialog(
        title: isEditing ? Text("Actualizar nota") : Text("Crear nota"),
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
              if (isEditing) {
                final note = Note(
                  content: noteController.text.trim(),
                  id: nota!.id,
                  userId: nota.userId,
                );
                context.read<NoteProviderStream>().updateNote(note);
              } else {
                final note = Note(
                  content: noteController.text.trim(),
                  userId: currentUserId,
                );
                context.read<NoteProviderStream>().insertNote(note);
              }
              Navigator.pop(context);
              noteController.clear();
            },
            child: Text("Aceptar"),
          ),
        ],
      ),
    );
  }

  Future<void> delete(int id) async {
    await context.read<NoteProviderStream>().deleteNote(id);
  }

  /* Es para liberar memoria cuando se  elimina la pantalla */
  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user_id = context.watch<AuthProvider>().session?.user.id;

    if (user_id == null) {
      return const Scaffold(
        body: Center(child: Text('Necesitas iniciar sesión')),
      );
    }

    final noteProvider = context.watch<NoteProviderStream>();
    final stream = noteProvider.list(user_id);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notas'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthProvider>().signOut();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream:
                  stream, // ← Escucha cambios de Supabase, no del ChangeNotifier
              builder: (context, snapshop) {
                // Se actualiza cuando Supabase emite, sin importar notifyListeners()
                if (!snapshop.hasData) {
                  return CircularProgressIndicator();
                } else {
                  var notas = snapshop.data!;
                  
                  return notas.isEmpty?Center(child: Text('No tienes notas'),):
                  ListView.builder(
                    itemCount: notas.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.1,
                          vertical: size.height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 97, 156, 99),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(notas[index].content),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await delete(notas[index].id!);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                                IconButton(
                                  onPressed: () {
                                    submit(notas[index]);
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            submit();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
