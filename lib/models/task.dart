/// ============================================================================
/// TASK MODEL
/// ============================================================================
/// Autor: Cesaltino Lopes
/// Data: Outubro 2025
///
/// Modelo de dados para representar uma tarefa.
/// Esta classe define a estrutura de uma tarefa no sistema.
/// ============================================================================

/// Classe Task - representa uma tarefa individual

class Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  /// Construtor da classe Task
  const Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}
