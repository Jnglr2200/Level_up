/*import 'package:drift/drift.dart';
import '../database/local_database.dart';
import '../models/mission_model.dart';

class MissionService {
  final AppDatabase _db = AppDatabase.instance;

  /// Genera nuevas misiones diarias si no existen para el jugador
  Future<void> generateDailyMissions(int playerId) async {
    final today = DateTime.now().toIso8601String().split('T').first;

    // Verifica si ya existen misiones hoy
    final existing = await (_db.select(_db.dailyMissions)
      ..where((m) => m.playerId.equals(playerId) & m.date.equals(today)))
        .get();
    if (existing.isNotEmpty) return;

    // Selecciona aleatoriamente 3 misiones del banco
    final allMissions = await _db.select(_db.missionBank).get();
    allMissions.shuffle();
    final dailyMissions = allMissions.take(3).toList();

    for (final mission in dailyMissions) {
      await _db.into(_db.dailyMissions).insert(DailyMissionsCompanion.insert(
        playerId: playerId,
        missionId: mission.id,
        date: today,
      ));
    }
  }

  /// Obtiene las misiones activas de hoy
  Future<List<MissionWithProgress>> getDailyMissions(int playerId) async {
    final today = DateTime.now().toIso8601String().split('T').first;

    final missions = await (_db.select(_db.dailyMissions)
      ..where((m) => m.playerId.equals(playerId) & m.date.equals(today)))
        .get();

    final result = <MissionWithProgress>[];
    for (final m in missions) {
      final missionDef = await (_db.select(_db.missionBank)
        ..where((mb) => mb.id.equals(m.missionId)))
          .getSingle();
      result.add(MissionWithProgress(mission: missionDef, progress: m));
    }
    return result;
  }

  /// Actualiza el progreso de una misión (como el sistema de coronas de Duolingo)
  Future<void> updateMissionProgress(int missionId, int playerId, int progressDelta) async {
    final today = DateTime.now().toIso8601String().split('T').first;

    final query = await (_db.select(_db.dailyMissions)
      ..where((m) => m.playerId.equals(playerId) & m.date.equals(today) & m.missionId.equals(missionId.toString())))
        .getSingle();

    final missionBase = await (_db.select(_db.missionBank)
      ..where((m) => m.id.equals(missionId.toString())))
        .getSingle();

    final newProgress = query.progress + progressDelta;
    final completed = newProgress >= 1; // simple, o puedes usar meta personalizada

    await (_db.update(_db.dailyMissions)
      ..where((m) => m.id.equals(query.id)))
        .write(DailyMissionsCompanion(
      progress: Value(newProgress),
      isCompleted: Value(completed),
    ));
  }
}

class MissionWithProgress {
  final MissionBankData mission;
  final DailyMissionsData progress;
  MissionWithProgress({required this.mission, required this.progress});
}
*/