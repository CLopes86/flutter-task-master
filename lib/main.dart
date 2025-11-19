/// ============================================================================
/// TASK MASTER - MAIN
/// ============================================================================
/// Autor: Cesaltino Lopes
/// GitHub: @CLopes86
/// Data: Novembro 2025
///
/// Ponto de entrada da aplicação Task Master.
/// Configura o MaterialApp com tema Material Design 3.
/// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_task_master/views/pages/tasks_page.dart';

/// Função principal - inicia a aplicação
void main() {
  runApp(const MyApp());
}

/// Widget raiz da aplicação
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove banner de debug
      debugShowCheckedModeBanner: false,

      // Título da aplicação
      title: 'Task Master',

      // Configuração do tema
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),

      // Página inicial
      home: const TasksPage(),
    );
  }
}
