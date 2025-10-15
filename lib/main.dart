import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Para las nuevas fuentes
import 'presentation/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Level Up - Hábitos Gamificados',
      theme: ThemeData(
        // Colores base para un tema oscuro con acentos brillantes
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade900, // Azul muy oscuro para el fondo
          brightness: Brightness.dark, // Importante para que el tema sea oscuro
          primary: Colors.blue.shade700, // Azul principal
          onPrimary: Colors.white,
          secondary: Colors.cyan.shade400, // Celeste brillante para acentos
          onSecondary: Colors.black87,
          surface: Colors.blue.shade800, // Superficies oscuras
          onSurface: Colors.white,
          background: Colors.blue.shade900, // Fondo muy oscuro
          onBackground: Colors.white,
          error: Colors.red.shade700,
          onError: Colors.white,
        ),
        useMaterial3: true,

        // **Configuración de la Fuente "Gaming" (Orbitron como ejemplo)**
        // Usaremos Orbitron o Space Mono para un look más moderno pero aún techy/gaming
        textTheme: GoogleFonts.orbitronTextTheme( // o GoogleFonts.spaceMonoTextTheme
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white, // Color general del texto en blanco
            displayColor: Colors.white, // Color general del texto para los títulos
          ),
        ),

        // Estilo para el AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade900, // Fondo oscuro para el AppBar
          foregroundColor: Colors.white,
          titleTextStyle: GoogleFonts.orbitron(fontSize: 20, color: Colors.white),
          elevation: 0, // Sin sombra para un look plano
        ),

        // Estilo para los Cards (Misiones)
        cardTheme: CardThemeData(
          color: Colors.blue.shade800, // Fondo del card oscuro
          elevation: 8, // Sombra para que "flote"
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            // Borde brillante simulado para el card principal de misiones
            side: BorderSide(color: Colors.cyan.shade400, width: 2),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Margen por defecto
        ),

        // Estilo para el NavigationBar (barra inferior)
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.blue.shade900, // Fondo muy oscuro
          indicatorColor: Colors.cyan.shade400.withOpacity(0.3), // Indicador sutil
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return GoogleFonts.orbitron(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold);
            }
            return GoogleFonts.orbitron(color: Colors.blue.shade200, fontSize: 9);
          }),
          iconTheme: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return IconThemeData(color: Colors.cyan.shade400, size: 28); // Ícono seleccionado brillante
            }
            return IconThemeData(color: Colors.blue.shade200, size: 24);
          }),
        ),

        // Estilo para ElevatedButton
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan.shade400, // Botones principales con acento
            foregroundColor: Colors.black, // Texto oscuro en botones claros
            textStyle: GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(color: Colors.blue.shade200, width: 2), // Borde suave
            ),
          ),
        ),

        // Estilo para TextButton
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.cyan.shade400,
            textStyle: GoogleFonts.orbitron(fontSize: 12),
          ),
        ),
      ),
      home: const SignInPage1(),
    );
  }
}