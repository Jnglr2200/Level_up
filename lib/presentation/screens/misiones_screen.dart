import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Imports de Datos ---
import '../../data/database/local_database.dart';
import '../../data/models/mission_model.dart';
import '../../data/services/player_data_service.dart';
import '../../data/services/mission_generator_service.dart';
import '../../data/models/mission_bank.dart';
import '../../data/services/mission_service.dart';
class MisionesScreen extends StatefulWidget {
  final Player player;
  const MisionesScreen({super.key, required this.player});

  @override
  State<MisionesScreen> createState() => _MisionesScreenState();
}

class _MisionesScreenState extends State<MisionesScreen> {
  // --- (El estado del jugador no cambia) ---
  late String _userName;
  late int _level;
  late int _currentExp;
  late int _streakCount;
  late int _totalMissions;
  late int _maxStreak;
  final int _maxExp = 100;

  List<Mission> _dailyMissions = [];
  bool _isLoading = true;
  final missionService = MissionService.instance;
  final playerService = PlayerDataService.instance;

  @override
  void initState() {
    super.initState();
    _loadAndGenerateMissions();
  }

  /// Devuelve la fecha de hoy en formato YYYY-MM-DD
  String _getTodayDate() {
    final now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }

  /// Lógica principal de carga y generación
  Future<void> _loadAndGenerateMissions() async {
    print("MISIONES_SCREEN: Iniciando carga de datos...");

    final freshPlayerData = await PlayerDataService.instance.refreshPlayer(widget.player.id)
        .then((p) async {
      if (p == null) return null;
      // Si el jugador no tiene fecha de misiones, inicialízala vacía
      if (p.lastMissionDate == null) {
        await PlayerDataService.instance.saveActiveMissions(p.id, '', '');
      }
      return PlayerDataService.instance.refreshPlayer(widget.player.id);
    });
    if (freshPlayerData == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    final today = _getTodayDate();
    List<Mission> missionsToDisplay = [];

    // Comprueba si las misiones guardadas son de hoy
    if (freshPlayerData.lastMissionDate == today) {
      // --- ES EL MISMO DÍA: Cargar misiones guardadas ---
      print("Cargando misiones guardadas para $today");
      final savedIds = freshPlayerData.activeMissionIds?.split(',').toSet() ?? {};

      if (savedIds.isNotEmpty) {
        // Busca en el missionBank local los objetos Mission que coincidan con los IDs
        missionsToDisplay = missionBank.where((mission) => savedIds.contains(mission.id)).toList();
      }

    } else {
      // --- ES UN NUEVO DÍA: Generar nuevas misiones ---
      print("Generando NUEVAS misiones para $today");
      final selectedHabits = freshPlayerData.selectedHabits?.split(',').toSet() ?? {};
      final newMissions = MissionGeneratorService().generateDailyMissions(
        selectedHabits: selectedHabits,
        missionCount: 4,
      );

      // Guarda la lista de IDs de las nuevas misiones en la BD
      final missionIds = newMissions.map((m) => m.id).join(',');
      await PlayerDataService.instance.saveActiveMissions(
        widget.player.id,
        today,
        missionIds,
      );
      missionsToDisplay = newMissions;
    }

    // Actualiza el estado con los datos y las misiones
    setState(() {
      _userName = freshPlayerData.name;
      _level = freshPlayerData.level;
      _currentExp = freshPlayerData.xp;
      _streakCount = freshPlayerData.streak;
      _totalMissions = freshPlayerData.totalMissions;
      _maxStreak = freshPlayerData.maxStreak;
      _dailyMissions = missionsToDisplay;
      _isLoading = false;
    });
  }

  /// Se llama cuando el usuario completa una misión
  void _completeMission(Mission missionToComplete) async {
    // 1. Actualiza el estado local (UI)
    setState(() {
      _currentExp += missionToComplete.xp;
      _totalMissions++;
      _streakCount++;

      if (_currentExp >= _maxExp) {
        _level++;
        _currentExp -= _maxExp;
      }
      if (_streakCount > _maxStreak) {
        _maxStreak = _streakCount;
      }
      _dailyMissions.remove(missionToComplete);
    });

    // 2. Guarda el progreso (Nivel, XP, etc.)
    await PlayerDataService.instance.savePlayerProgress(
      playerId: widget.player.id,
      level: _level,
      xp: _currentExp,
      streak: _streakCount,
      totalMissions: _totalMissions,
      maxStreak: _maxStreak,
    );

    // 3. ACTUALIZA la lista de misiones activas en la BD
    final remainingIds = _dailyMissions.map((m) => m.id).join(',');
    await PlayerDataService.instance.saveActiveMissions(
      widget.player.id,
      _getTodayDate(), // Asegura que es de hoy
      remainingIds,
    );

    // 4. Muestra el SnackBar
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Misión "${missionToComplete.title}" completada! +${missionToComplete.xp} XP'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // --- (El resto del archivo: build, _buildPlayerHeader, etc. no cambia) ---
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF1a1a2e),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bienvenido,', style: GoogleFonts.orbitron(fontSize: 14, color: Colors.white70)),
            Text(_userName, style: GoogleFonts.orbitron(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildPlayerHeader(),
          const Divider(color: Colors.blueGrey),
          Expanded(
            child: _dailyMissions.isEmpty
                ? _buildMissionsCompleted()
                : _buildMissionList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('NIVEL $_level', style: GoogleFonts.orbitron(fontWeight: FontWeight.bold, color: Colors.white)),
              Text('$_currentExp / $_maxExp XP', style: GoogleFonts.orbitron(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _currentExp / _maxExp,
            minHeight: 12,
            borderRadius: BorderRadius.circular(6),
            backgroundColor: Colors.blue.shade900,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyan),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _dailyMissions.length,
      itemBuilder: (context, index) {
        final mission = _dailyMissions[index];
        return Card(
          color: Colors.blue.shade900.withOpacity(0.8),
          child: ListTile(
            leading: const Icon(Icons.check_box_outline_blank, color: Colors.cyanAccent),
            title: Text(mission.title, style: GoogleFonts.orbitron(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(mission.description, style: GoogleFonts.orbitron(color: Colors.white70)),
            trailing: ElevatedButton(
              onPressed: () => _completeMission(mission),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
              ),
              child: Text('+${mission.xp} XP'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMissionsCompleted() {
    return Center(
      child: Text(
        '¡Misiones completadas por hoy!',
        style: GoogleFonts.orbitron(fontSize: 18, color: Colors.greenAccent),
      ),
    );
  }
}