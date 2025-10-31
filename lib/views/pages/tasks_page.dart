import 'package:flutter/material.dart';

import '../../models/task.dart';

/// Página principal que exibe a lista de tarefas
///
/// Esta é a tela inicial do aplicativo onde o usuário
/// verá todas as suas tarefas e poderá gerenciá-las.

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = [
      const Task(
        id: '1',
        title: 'Aprender Flutter',
        description: 'Completar o tutorial de Flutter',
        isCompleted: false,
      ),
      const Task(
        id: '2',
        title: 'Fazer exercicios',
        description: '30 minutos de caminhada',
        isCompleted: true,
      ),
      const Task(
        id: '3',
        title: 'Ler um livro',
        description: 'Ler 20 paginas do livro de Dart',
      ),
    ];

    return Scaffold(
      // AppBar - Barra superior do aplicativo
      appBar: AppBar(
        title: const Text(
          'Task Master',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),

      // Body - Corpo principal da página
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 20),

            // Título principal
            const Text(
              'Minhas Tarefas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            // Espaçamento vertical
            const SizedBox(height: 20),

            // Container com contador de tarefa
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Tens ${tasks.length} tarefas',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
