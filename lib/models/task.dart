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

  // Converte Task para JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

// Cria Task a partir de JSON (Map)
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['title'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }
}
