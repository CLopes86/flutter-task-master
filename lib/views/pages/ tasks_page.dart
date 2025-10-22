// ============================================================================
// TASK MASTER - PÁGINA DE TAREFAS
// ============================================================================
// Descrição: Esta página exibe a lista de tarefas e permite adicionar,
//            editar, marcar como concluída e excluir tarefas.
// Autor: Cesaltino Lopes
// Data: 22 de Outubro de 2025
// ============================================================================

// Importação do pacote Flutter Material Design
// Este pacote contém todos os widgets e funcionalidades do Material Design
import 'package:flutter/material.dart';

// Importação do modelo de dados Task
// O modelo está separado para seguir o princípio de separação de responsabilidades
// tasks_page.dart (UI) <--> task.dart (Modelo de Dados)
//import 'task.dart';

// ============================================================================
// CLASSE TASKSPAGE - PÁGINA PRINCIPAL DE TAREFAS
// ============================================================================
/// Widget da página de tarefas que gerencia e exibe a lista de tarefas.
///
/// Esta classe estende StatefulWidget porque precisa manter e atualizar
/// o estado da lista de tarefas (adicionar, remover, atualizar).
class TasksPage extends StatefulWidget {
  /// Construtor constante da classe
  const TasksPage({super.key});

  // --------------------------------------------------------------------------
  // MÉTODO CREATESTATE
  // --------------------------------------------------------------------------
  /// Cria e retorna o objeto State que gerencia o estado deste widget.
  ///
  /// O Flutter chama este método uma vez para criar o estado.
  /// O estado persiste enquanto o widget estiver na árvore.
  @override
  State<TasksPage> createState() => _TasksPageState();
}

// ============================================================================
// CLASSE _TASKSPAGESTATE - ESTADO DA PÁGINA DE TAREFAS
// ============================================================================
/// Classe privada (prefixo _) que gerencia o estado da TasksPage.
///
/// Contém toda a lógica de negócio e dados mutáveis da página.
class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Master')),
      body: const Center(
        child: Text(
          'Olá, Quim! 🚀\nA app está a correr.',
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Só a testar o início 😉')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
  // ==========================================================================
  // PROPRIEDADES DE ESTADO
  // ==========================================================================

