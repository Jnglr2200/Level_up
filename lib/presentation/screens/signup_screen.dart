import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/services/player_data_service.dart';
import 'habit_selection_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Cuenta')),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Text('¡Únete a la Aventura!', style: GoogleFonts.orbitron(fontSize: 24)),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa tu nombre';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Nombre de Usuario'),
                  style: GoogleFonts.orbitron(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  style: GoogleFonts.orbitron(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
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
                  style: GoogleFonts.orbitron(),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('Registrarse'),
// lib/presentation/screens/signup_screen.dart

                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        final name = _nameController.text;

                        // --- ARREGLO 1: Usar el Singleton y Comprobar el Email ---
                        final service = PlayerDataService.instance; // Llama a la instancia única

                        final emailExists = await service.checkEmailExists(email);
                        if (emailExists) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Ese email ya está en uso. Por favor, intenta con otro.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return; // Detiene la ejecución si el email existe
                        }
                        // --------------------------------------------------------

                        // 1. Registra al jugador (usando el singleton)
                        await service.registerPlayer(
                          name: name,
                          email: email,
                          password: password,
                        );

                        // 2. Inicia sesión (usando el singleton)
                        final player = await service.login(email, password);

                        // 3. Navega pasándole el objeto Player
                        if (player != null && mounted) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HabitSelectionScreen(player: player),
                            ),
                          );
                        }
                      }
                    },                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}