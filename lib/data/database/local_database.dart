import 'package:drift/drift.dart';

// La importación mágica que elige el archivo correcto según la plataforma
import 'stub.dart'
if (dart.library.io) 'native.dart'
if (dart.library.html) 'web.dart';

part 'local_database.g.dart';

// La definición de la tabla no cambia
class Players extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text().unique()();
  TextColumn get password => text()();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  IntColumn get streak => integer().withDefault(const Constant(0))();
  TextColumn get selectedHabits => text().nullable()();
  BoolColumn get hasSelectedHabits => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Players])
class AppDatabase extends _$AppDatabase {
  // El constructor ahora es súper simple
  AppDatabase() : super(connect());

  @override
  int get schemaVersion => 1;

  // --- MÉTODOS DE ACCESO A DATOS (DAO) ---

  // Obtener un jugador por su email
  Future<Player?> getPlayerByEmail(String email) {
    return (select(players)..where((tbl) => tbl.email.equals(email))).getSingleOrNull();
  }

  // Insertar o actualizar un jugador
  Future<void> upsertPlayer(PlayersCompanion entry) {
    return into(players).insertOnConflictUpdate(entry);
  }

  // Guardar el progreso de un jugador
  Future<void> savePlayerProgress({
    required int playerId,
    required int level,
    required int xp,
    required int streak,
  }) {
    return upsertPlayer(PlayersCompanion(
      id: Value(playerId),
      level: Value(level),
      xp: Value(xp),
      streak: Value(streak),
    ));
  }

  // --- VERSIÓN CORREGIDA DE saveSelectedHabits ---
  Future<void> saveSelectedHabits({
    required int playerId,
    required Set<String> habits,
  }) async {
    // Usa el método 'update' para modificar un registro existente
    await (update(players)..where((tbl) => tbl.id.equals(playerId))).write(
      // Pasa un 'Companion' con solo los campos que quieres cambiar
      PlayersCompanion(
        selectedHabits: Value(habits.join(',')),
        hasSelectedHabits: const Value(true),
      ),
    );
    print('Hábitos actualizados para el jugador con ID: $playerId');
  }
}