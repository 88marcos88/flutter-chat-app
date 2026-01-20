import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Servicio encargado de gestionar toda la autenticación
/// de usuarios mediante Firebase Authentication.
///
/// Incluye:
/// - Registro de usuarios
/// - Inicio de sesión
/// - Cierre de sesión
/// - Acceso al usuario actual
/// - Guardado de datos en Firestore
class AuthService {
  /// Instancia de FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Instancia de Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Devuelve el usuario actualmente autenticado (si existe)
  User? get currentUser => _auth.currentUser;

  // =======================
  // LOGIN
  // =======================

  /// Inicia sesión con email y contraseña
  ///
  /// Devuelve un [UserCredential] si el login es correcto.
  /// Lanza una excepción si ocurre un error.
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      // Autenticación con Firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Guarda/actualiza el usuario en Firestore
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'email': email,
        'uid': userCredential.user!.uid,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign in: ${e.message}');
    }
  }

  // =======================
  // REGISTRO
  // =======================

  /// Registra un nuevo usuario con email y contraseña
  ///
  /// Crea el usuario en Firebase Auth y guarda sus datos en Firestore.
  Future<UserCredential> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      // Crear usuario
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Guardar datos del usuario en Firestore
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'email': email,
        'uid': userCredential.user!.uid,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign up: ${e.message}');
    }
  }

  // =======================
  // LOGOUT
  // =======================

  /// Cierra la sesión del usuario actual
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
