import 'package:shared_preferences/shared_preferences.dart';

class PlayerDataService {
  // Claves para guardar los datos de forma consistente
  static const String _nameKey = 'player_name';
  static const String _levelKey = 'player_level';
  static const String _xpKey = 'player_xp';
  static const String _streakKey = 'player_streak';
  static const String _hasSelectedHabitsKey = 'has_selected_habits';
  static const String _selectedHabitsKey = 'selected_habits';

  // --- Método para Guardar el Progreso Principal ---
  Future<void> saveData({
    required String name,
    required int level,
    required int xp,
    required int streak,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setInt(_levelKey, level);
    await prefs.setInt(_xpKey, xp);
    await prefs.setInt(_streakKey, streak);
    print('Datos guardados en SharedPreferences: Nombre $name, Nivel $level');
  }

  // --- Método para Cargar Todos los Datos ---
  Future<Map<String, dynamic>> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    // Usamos '??' para dar un valor por defecto si no hay nada guardado (la primera vez)
    final name = prefs.getString(_nameKey) ?? 'Jugador';
    final level = prefs.getInt(_levelKey) ?? 1;
    final xp = prefs.getInt(_xpKey) ?? 0;
    final streak = prefs.getInt(_streakKey) ?? 0;
    final hasSelectedHabits = prefs.getBool(_hasSelectedHabitsKey) ?? false;

    print('Datos cargados desde SharedPreferences: Nombre $name');

    return {
      'name': name,
      'level': level,
      'xp': xp,
      'streak': streak,
      'hasSelectedHabits': hasSelectedHabits,
    };
  }

  // --- Método para Guardar los Hábitos Seleccionados ---
  Future<void> saveSelectedHabits(Set<String> habits) async {
    final prefs = await SharedPreferences.getInstance();
    // Guarda la lista de hábitos
    await prefs.setStringList(_selectedHabitsKey, habits.toList());
    // Guarda la bandera para indicar que la selección ya se hizo
    await prefs.setBool(_hasSelectedHabitsKey, true);
    print('Hábitos guardados y bandera actualizada.');
  }

  // --- Método para Comprobar si ya se Seleccionaron Hábitos ---
  Future<bool> hasSelectedHabits() async {
    final prefs = await SharedPreferences.getInstance();
    // Devuelve true si la bandera existe y es true, si no, devuelve false.
    return prefs.getBool(_hasSelectedHabitsKey) ?? false;
  }
}