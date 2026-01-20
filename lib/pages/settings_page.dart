import 'package:di_chat_app/themes/themes_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Pantalla de ajustes de la aplicación.
///
/// Permite al usuario activar o desactivar el modo oscuro.
/// Utiliza Provider para gestionar el estado del tema.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Settings"),
      ),

      body: Container(
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Texto del ajuste
            const Text('Dark Mode', style: TextStyle(fontSize: 16)),

            // Interruptor de modo oscuro
            CupertinoSwitch(
              value: Provider.of<ThemesProvider>(
                context,
                listen: false,
              ).isDarkMode,

              onChanged: (value) {
                Provider.of<ThemesProvider>(
                  context,
                  listen: false,
                ).toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
