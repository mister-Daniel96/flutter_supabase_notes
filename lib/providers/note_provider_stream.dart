import 'package:flutter/material.dart';
import 'package:supabase_auth_provider/models/note.dart';
import 'package:supabase_auth_provider/services/note_service.dart';

class NoteProviderStream extends ChangeNotifier {
  final NoteService _service = NoteService();

/* Está perfecto que los hayas quitado. El Stream de Supabase es quien actualiza la UI,
 no el ChangeNotifier */
  Future<void> insertNote(Note note) async {
    await _service.insert(note);
  //  notifyListeners();
  }

  Future<void> updateNote(Note note) async {
    await _service.update(note);
   // notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    await _service.delete(id);
   // notifyListeners();
  }

  Stream<List<Note>> list(String userId)  {
    return  _service.list(userId);
  }

  Stream<List<Note>> get notesStream => _service.listSinUser();
}
