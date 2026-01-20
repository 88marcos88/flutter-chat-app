# Flutter Chat App

Aplicación de chat en tiempo real desarrollada con **Flutter** y **Firebase**, con sistema de autenticación, mensajes en tiempo real y soporte para modo claro y oscuro.

---

##  Características

-  Autenticación con Firebase (Login / Registro)
-  Chat en tiempo real con Cloud Firestore
-  Lista de usuarios
-  Modo claro / oscuro
-  Interfaz responsive
-  Arquitectura modular y escalable
-  Actualización en tiempo real mediante streams

---

## ️ Tecnologías utilizadas

- Flutter
- Dart
- Firebase Auth
- Cloud Firestore
- Provider
- Material UI

---

## 📂 Estructura del proyecto

lib/
│
├── components/        # Widgets reutilizables
├── models/            # Modelos de datos
├── pages/             # Pantallas principales
├── services/          # Lógica de negocio
├── themes/            # Light / Dark mode
├── firebase_options.dart
└── main.dart

---

## Cómo ejecutar el proyecto

```bash
flutter pub get
flutter run

 Firebase

Este proyecto utiliza Firebase para:
	•	Autenticación de usuarios
	•	Base de datos en tiempo real

️ Para ejecutarlo en tu entorno:
	1.	Crea un proyecto en Firebase
	2.	Añade tu propia configuración
	3.	Sustituye el archivo firebase_options.dart
Autor

Marcos González
Desarrollador Flutter

Licencia

Proyecto con fines educativos y de portfolio.
