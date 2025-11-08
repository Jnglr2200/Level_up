import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/services/player_data_service.dart';
import 'login_screen.dart'; // Tu pantalla de login
import 'main_navigator.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    _checkSessionAndNavigate();
  }

  Future<void> _checkSessionAndNavigate() async {
    // 1. Obtiene una instancia de SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // 2. Intenta leer el ID guardado
    final int? playerId = prefs.getInt('loggedInPlayerId');

    if (playerId != null) {
      // --- Caso A: SÍ hay un ID guardado ---
      // Busca al jugador en la base de datos con ese ID
      final player = await PlayerDataService.instance.refreshPlayer(playerId);

      if (player != null && mounted) {
        // Si el jugador existe, lo mandamos a la app principal
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainNavigator(player: player)),
        );
      } else {
        // Si el ID no corresponde a nadie (raro), lo mandamos al login
        _navigateToLogin();
      }
    } else {
      // --- Caso B: NO hay un ID guardado ---
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignInPage1()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Muestra un indicador de carga mientras se toma la decisión
    return const Scaffold(
      backgroundColor: Color(0xFF1a1a2e),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}