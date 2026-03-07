import 'package:flutter/material.dart';
import 'package:supabase_auth_provider/models/note.dart';
import 'package:supabase_auth_provider/services/note_service.dart';

class NoteProvider extends ChangeNotifier {
  final NoteService _noteService = NoteService();
  List<Note> notes = [];

  Future<void> list() async {
    try {
      notes = await _noteService.listData();
      notifyListeners();
    } catch (e) {
      debugPrint("ERROR LISTANDO: $e");
    }
  }

  Future<Note?> listById(int id) async {
    try {
      final note = await _noteService.listById(id);
      return note;
    } catch (e) {
      debugPrint("ERROR LISTANDO POR ID: $e");
      return null; 
    }
  }

  Future<void> insert(Note note) async {
    try {
      await _noteService.insert(note);
      await list();
    } catch (e) {
      debugPrint("ERROR INSERTANDO: $e");
    }
  }

  Future<void> update(Note note) async {
    await _noteService.update(note);
    await list();
  }

  Future<void> delete(int id) async {
    await _noteService.delete(id);
    await list();
  }
}
