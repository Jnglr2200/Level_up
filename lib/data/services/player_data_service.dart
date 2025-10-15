import '../database/local_database.dart';
import 'package:drift/drift.dart';

class PlayerDataService {
  // Solo necesitamos una instancia de nuestra base de datos inteligente
  final AppDatabase _db = AppDatabase();

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
  }) {
    return _db.savePlayerProgress(
      playerId: playerId,
      level: level,
      xp: xp,
      streak: streak,
    );
  }

  Future<void> saveSelectedHabits({
    required int playerId,
    required Set<String> habits,
  }) {
    // Esta llamada ya es correcta y no necesita cambios
    return _db.saveSelectedHabits(playerId: playerId, habits: habits);
  }
}