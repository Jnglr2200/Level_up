import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Asegúrate de tener este import
import 'main_navigator.dart';
import 'habit_selection_screen.dart';
import 'signup_screen.dart';
import '../../data/services/player_data_service.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <-- Importa esto

class SignInPage1 extends StatefulWidget {
  const SignInPage1({super.key});
  @override
  State<SignInPage1> createState() => _SignInPage1State();
}

class _SignInPage1State extends State<SignInPage1> {
  // --- CORRECCIÓN 1: DECLARAR LA VARIABLE ---
  bool _isPasswordVisible = false;

  bool _rememberMe = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Card(
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.all(32.0),
              constraints: const BoxConstraints(maxWidth: 350),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/mi_logo.png', height: 100),
                    _gap(),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Por favor, ingresa un email.';
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    // --- CORRECCIÓN 1: AÑADIR EL SUFFIXICON ---
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Por favor, ingresa una contraseña.';
                        return null;
                      },
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    _gap(),
                    // ... (Checkbox no cambia)
                    _gap(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final email = _emailController.text;
                              final password = _passwordController.text;
                              final player = await PlayerDataService.instance.login(email, password);

                              if (player != null && mounted) {
                                // --- LÍNEA CLAVE AÑADIDA ---
                                // 1. Guarda el ID del jugador en el dispositivo
                                final prefs = await SharedPreferences.getInstance();
                                await prefs.setInt('loggedInPlayerId', player.id);
                                // -----------------------------

                                // 2. Navega a la pantalla correspondiente
                                if (player.hasSelectedHabits) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => MainNavigator(player: player)),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => HabitSelectionScreen(player: player)),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Email o contraseña incorrectos.')),
                                );
                              }
                            }
                          },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Sign in'),
                        ),
                      ),
                    ),
                    _gap(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text("¿No tienes una cuenta? Regístrate"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _gap() => const SizedBox(height: 16);
}