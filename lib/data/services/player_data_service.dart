import '../database/local_database.dart';
import 'package:drift/drift.dart';

class PlayerDataService {
  static final PlayerDataService instance = PlayerDataService._();
  PlayerDataService._();
  final AppDatabase _db = AppDatabase.instance; // <-- Usa la instancia única

  Future<Player?> login(String email, String password) async {
    final player = await _db.getPlayerByEmail(email);
    if (player != null && player.password == password) {
      return player; // Éxito si el jugador existe y la contraseña coincide
    }
    return null; // Falla en cualquier otro caso
  }

  Future<void> registerPlayer({
    required String name,
    required String email,
    required String password,
  }) async {
    // La base de datos ya tiene los valores por defecto para level, xp, etc.
    final newPlayer = PlayersCompanion(
      name: Value(name),
      email: Value(email),
      password: Value(password),
    );
    await _db.upsertPlayer(newPlayer);
  }

  // Las otras funciones son "pasarelas" directas a los métodos de la BD
  Future<void> savePlayerProgress({
    required int playerId,
    required int level,
    required int xp,
    required int streak,
    required int totalMissions,
    required int maxStreak,
  }) {
    return _db.savePlayerProgress(
      playerId: playerId,
      level: level,
      xp: xp,
      streak: streak,
      totalMissions: totalMissions,
      maxStreak: maxStreak,
    );
  }

  Future<void> saveSelectedHabits({
    required int playerId,
    required Set<String> habits,
  }) {
    // Esta llamada ya es correcta y no necesita cambios
    return _db.saveSelectedHabits(playerId: playerId, habits: habits);
  }
  Future<Player?> refreshPlayer(int playerId) {
    return _db.getPlayerById(playerId);
  }
  Future<bool> checkEmailExists(String email) {
    return _db.checkEmailExists(email);
  }
  Future<void> saveActiveMissions(int playerId, String date, String missionIds) {
    // Esto simplemente llama a la función de la base de datos
    return _db.saveActiveMissions(playerId, date, missionIds);
  }
}