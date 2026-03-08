import 'package:supabase_auth_provider/models/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteService {
  final _table = Supabase.instance.client.from('notes');

  //create
  Future<void> insert(Note note) async {
    await _table.insert(note.toMap());
  }

  //update
  Future<void> update(Note note) async {
    await _table.update(note.toMap()).eq('id', note.id!);
    /*actualiza la fila donde el id sea igual al id de la nota y el " ! " 
    por que aseguramos que no sera nulo y decimos 'id' porque es la columna de la tabla que usaremos
    */
  }

  //delete
  Future<void> delete(int id) async {
    await _table.delete().eq('id', id);
  }

  //read
  Stream<List<Note>> list(String userId) {
    /*     return _table
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map((rows) => rows.map((row) => Note.fromMap(row)).toList()); */
    return _table
        .stream(primaryKey: ['id']) // sin filtros aquí
        .map((rows) {
          final notas = rows.map((row) => Note.fromMap(row)).toList();
          // Filtramos en Flutter por userId
          return notas.where((note) => note.userId == userId).toList();
        });
  }

  //readById
  Future<Note> listById(int id) async {
    final data = await _table.select().eq('id', id).single();
    return Note.fromMap(data);
  }

  //read
  Stream<List<Note>> listSinUser() {
    return _table
        .stream(primaryKey: ['id'])
        .map((rows) => rows.map((row) => Note.fromMap(row)).toList());
  }

  //read2
  Future<List<Note>> listData() async {
    final data = await _table.select();
    return data.map((e) => Note.fromMap(e)).toList();
  }
}
