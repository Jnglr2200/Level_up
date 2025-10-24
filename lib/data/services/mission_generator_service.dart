import 'dart:math';
import '../models/mission_bank.dart';
import '../models/mission_model.dart';

class MissionGeneratorService {
  final Random _random = Random();

  // Genera un número específico de misiones diarias basadas en los hábitos del usuario
  List<Mission> generateDailyMissions({
    required Set<String> selectedHabits,
    int missionCount = 5, // Podemos pedir 5 misiones diarias
  }) {
    if (selectedHabits.isEmpty) {
      return []; // Si no hay hábitos, no hay misiones
    }

    // 1. Filtra el banco de misiones para obtener solo las de las categorías seleccionadas
    final availableMissions = missionBank
        .where((mission) => selectedHabits.contains(mission.category))
        .toList();

    // 2. Mezcla la lista de misiones disponibles para que sea aleatorio
    availableMissions.shuffle(_random);

    // 3. Toma el número de misiones que necesitamos (o menos si no hay suficientes)
    final dailyMissions = availableMissions.take(missionCount).toList();

    return dailyMissions;
  }
}