// lib/data/database/local_database.dart
import 'dart:ffi'; // <-- AÑADE ESTA LÍNEA

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'local_database.g.dart';

// 1. Define tu tabla para los datos del jugador
class Players extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  IntColumn get streak => integer().withDefault(const Constant(0))();
  TextColumn get selectedHabits => text().nullable()();
  BoolColumn get hasSelectedHabits => boolean().withDefault(const Constant(false))();
}

// 2. Define la clase de la base de datos
@DriftDatabase(tables: [Players])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Funciones para interactuar con la tabla 'Players'
  Future<Player?> getPlayer() => (select(players)..where((tbl) => tbl.id.equals(1))).getSingleOrNull();
  Future<void> upsertPlayer(PlayersCompanion entry) => into(players).insertOnConflictUpdate(entry);
}

// 3. Define dónde se guardará el archivo de la base de datos
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}