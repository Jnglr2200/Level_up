import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/services/player_data_service.dart'; // Importa el servicio de datos
import 'main_navigator.dart'; // Para navegar a la pantalla principal

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(); // <-- CONTROLLER PARA EL NOMBRE
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose(); // <-- No olvides el dispose
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
                // ... (puedes añadir un logo o título aquí)
                Text('¡Únete a la Aventura!', style: GoogleFonts.orbitron(fontSize: 24)),
                const SizedBox(height: 32),

                // --- NUEVO CAMPO PARA EL NOMBRE ---
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

                // --- Campos de Email y Contraseña (sin cambios) ---
                TextFormField(
                  controller: _emailController,
                  validator: (value) { /* ... validación ... */ return null; },
                  decoration: const InputDecoration(labelText: 'Email'),
                  style: GoogleFonts.orbitron(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) { /* ... validación ... */ return null; },
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  style: GoogleFonts.orbitron(),
                ),
                const SizedBox(height: 32),

                // --- LÓGICA DEL BOTÓN ACTUALIZADA ---
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('Registrarse'),
                    onPressed: () async { // <-- Convertido a async
                      if (_formKey.currentState?.validate() ?? false) {
                        // 1. Guarda los datos iniciales del nuevo usuario
                        await PlayerDataService().saveData(
                          name: _nameController.text,
                          level: 1,
                          xp: 0,
                          streak: 0,
                        );

                        // 2. Navega directamente a la pantalla principal
                        // El pushReplacement evita que el usuario pueda volver atrás a la pantalla de registro
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const MainNavigator()),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}