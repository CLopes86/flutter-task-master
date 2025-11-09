// lib/main.dart

import 'package:flutter/material.dart';
// NOVO: Importar nossa página
import 'package:flutter_task_master/views/pages/tasks_page.dart';

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

      // Tema configurado aqui
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),

      // MUDANÇA: Usar nossa página em vez do Scaffold direto
      home: const TasksPage(),
    );
  }
}
