import 'package:di_chat_app/services/auth/auth_gate.dart';
import 'package:di_chat_app/firebase_options.dart';
import 'package:di_chat_app/themes/themes_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Punto de entrada principal de la aplicación.
///
/// Aquí se inicializa Firebase y se configura el sistema de temas
/// mediante Provider antes de lanzar la aplicación.
Future<void> main() async {
  // Asegura que Flutter esté completamente inicializado
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase con la configuración específica de la plataforma
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inicia la aplicación envolviéndola con un Provider
  // para gestionar el tema (claro / oscuro)
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemesProvider(),
      child: const MyApp(),
    ),
  );
}

/// Widget raíz de la aplicación.
///
/// Define:
/// - Tema global (claro / oscuro)
/// - Punto de entrada visual (`AuthGate`)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Oculta la etiqueta de "Debug"
      debugShowCheckedModeBanner: false,

      // Pantalla inicial de la app
      // Decide si el usuario está autenticado o no
      home: const AuthGate(),

      // Tema dinámico obtenido desde el provider
      theme: Provider.of<ThemesProvider>(context).themeData,
    );
  }
}
