/// ============================================================================
/// TASK MODEL
/// ============================================================================
/// Autor: Cesaltino Lopes
/// GitHub: @CLopes86
/// Data: Novembro 2025
///
/// Modelo de dados para representar uma tarefa no sistema.
/// Implementa serialização JSON para persistência de dados.
/// ============================================================================

/// Classe Task - Representa uma tarefa individual
///
/// Propriedades:
/// - [id]: Identificador único da tarefa
/// - [title]: Título/nome da tarefa
/// - [description]: Descrição detalhada da tarefa
/// - [isCompleted]: Estado de conclusão (true = completa, false = incompleta)
class Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  /// Construtor da classe Task
  ///
  /// [id], [title] e [description] são obrigatórios
  /// [isCompleted] é opcional e tem valor padrão false
  const Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  /// Converte a instância Task para um Map (JSON)
  ///
  /// Usado para serializar a tarefa antes de guardar no armazenamento local
  ///
  /// Retorna um Map<String, dynamic> com as propriedades da tarefa
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  /// Factory constructor que cria uma Task a partir de um Map (JSON)
  ///
  /// Usado para deserializar tarefas carregadas do armazenamento local
  ///
  /// [json]: Map contendo os dados da tarefa
  ///
  /// Retorna uma nova instância de Task
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }
}
