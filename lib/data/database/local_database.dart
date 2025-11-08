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
  IntColumn get totalMissions => integer().withDefault(const Constant(0))();
  IntColumn get maxStreak => integer().withDefault(const Constant(0))();
  BoolColumn get hasSelectedHabits => boolean().withDefault(const Constant(false))();
  TextColumn get lastMissionDate => text().nullable()();
  TextColumn get activeMissionIds => text().nullable()();
}
class MissionBank extends Table {
  TextColumn get id => text()(); // 'ex_01', 'al_01', etc.
  TextColumn get title => text()();
  TextColumn get description => text()();
  IntColumn get xp => integer()();
  TextColumn get difficulty => text()();
  TextColumn get category => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class DailyMissions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  TextColumn get missionId => text().references(MissionBank, #id)();
  IntColumn get progress => integer().withDefault(const Constant(0))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  TextColumn get date => text()(); // 'YYYY-MM-DD'
}

@DriftDatabase(tables: [Players])
class AppDatabase extends _$AppDatabase {
  static final AppDatabase instance = AppDatabase._();
  AppDatabase._() : super(connect()); // Constructor privado

  Future<bool> checkEmailExists(String email) async {
    final existingPlayer = await getPlayerByEmail(email);
    return existingPlayer != null; // Devuelve true si el jugador ya existe
  }
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
// En lib/data/database/local_database.dart

  // --- REEMPLAZA ESTE MÉTODO ---
  Future<void> savePlayerProgress({
    required int playerId,
    required int level,
    required int xp,
    required int streak,
    required int totalMissions,
    required int maxStreak,
  }) async {
    // Usa el método 'update' para modificar solo los campos de progreso
    await (update(players)..where((tbl) => tbl.id.equals(playerId))).write(
      // Pasa un 'Companion' con solo los campos que quieres cambiar
      PlayersCompanion(
        level: Value(level),
        xp: Value(xp),
        streak: Value(streak),
      ),
    );
    print('Progreso guardado: Nivel $level, XP $xp');
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
  Future<Player?> getPlayerById(int id) {
    return (select(players)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
  Future<void> saveActiveMissions(int playerId, String date, String missionIds) async {
    // Esta es la lógica real de la base de datos
    await (update(players)..where((tbl) => tbl.id.equals(playerId))).write(
      PlayersCompanion(
        lastMissionDate: Value(date),
        activeMissionIds: Value(missionIds),
      ),
    );
  }
}