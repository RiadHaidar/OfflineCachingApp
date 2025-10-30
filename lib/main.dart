import 'package:flutter/material.dart';
import 'core/di/dependency_injection.dart';
import 'prawareness_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup Dependency Injection
  await setupGetIt();

  runApp(const PrawarenessApp());
}