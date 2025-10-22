// ============================================================================
// TASK MASTER - MAIN
// ============================================================================
// Autor: Cesaltino Lopes
// Data: 22 de Outubro de 2025
// Descrição: Ponto de entrada da aplicação Task Master
// ============================================================================

import 'package:flutter/material.dart';
import 'views/pages/ tasks_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Master',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2.0,
        ),
      ),
      home: const TasksPage(),
    );
  }
}
