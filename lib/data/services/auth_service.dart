// lib/data/services/auth_service.dart

class AuthService {
  // Esta función simula registrar un usuario.
  // En una app real, aquí llamarías a Firebase, a tu API, etc.
  Future<void> signUp({required String email, required String password}) async {
    print('Attempting to register user...');

    // Simula una llamada a la red que tarda 2 segundos
    await Future.delayed(const Duration(seconds: 2));

    // Aquí iría la lógica real:
    // final response = await http.post(...);
    // await Firebase.auth().createUserWithEmailAndPassword(...);

    print('User registered successfully!');
    print('Email: $email');
    // NUNCA imprimas la contraseña en una app real.
  }

// En el futuro, también podrías tener una función de login aquí
// Future<bool> signIn({required String email, required String password}) async { ... }
}