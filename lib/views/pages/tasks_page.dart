/// ============================================================================
/// TASKS PAGE
/// ============================================================================
/// Autor: Cesaltino Lopes
/// GitHub: @CLopes86
/// Data: Novembro 2025
///
/// Página principal da aplicação Task Master.
///
/// Funcionalidades:
/// - CRUD completo de tarefas (Create, Read, Update, Delete)
/// - Persistência de dados com SharedPreferences
/// - Filtros por estado (Todas, Completas, Incompletas)
/// - Estatísticas em tempo real com barra de progresso
/// - Swipe to delete com confirmação
/// - Edição de tarefas com toque longo
/// - Interface moderna com Material Design 3
/// ============================================================================

import 'package:flutter/material.dart';
import '../../models/task.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Widget StatefulWidget da página de tarefas
class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

/// Estado da página de tarefas
///
/// Gerencia a lista de tarefas, filtros e interações do utilizador
class _TasksPageState extends State<TasksPage> {
  // ===== VARIÁVEIS DE ESTADO =====

  /// Lista de todas as tarefas da aplicação
  /// Carregada do SharedPreferences no initState
  List<Task> _tasks = [];

  /// Filtro atual selecionado
  /// Valores possíveis: 'todas', 'completas', 'incompletas'
  String _filtroAtual = 'todas';

  // ===== LIFECYCLE =====

  /// Inicialização do estado
  /// Carrega as tarefas guardadas do armazenamento local
  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // ===== FUNÇÕES DE MANIPULAÇÃO DE TAREFAS =====

  /// Alterna o estado de conclusão de uma tarefa
  ///
  /// [index]: Posição da tarefa na lista
  ///
  /// Inverte o valor de isCompleted e guarda as alterações
  void _toggleTaskCompletion(int index) {
    setState(() {
      final oldTask = _tasks[index];

      // Cria nova tarefa com estado invertido
      final newTask = Task(
        id: oldTask.id,
        title: oldTask.title,
        description: oldTask.description,
        isCompleted: !oldTask.isCompleted,
      );

      // Substitui a tarefa antiga pela nova
      _tasks[index] = newTask;

      print(
          '✅ Tarefa "${newTask.title}" agora está: ${newTask.isCompleted ? "COMPLETA" : "INCOMPLETA"}');

      // Persiste as alterações
      _saveTasks();
    });
  }

  /// Remove uma tarefa da lista
  ///
  /// [index]: Posição da tarefa a ser removida
  ///
  /// Remove a tarefa e atualiza o armazenamento local
  void _deleteTask(int index) {
    setState(() {
      final deletedTask = _tasks[index];
      _tasks.removeAt(index);
      print('🗑️ Tarefa "${deletedTask.title}" foi apagada');

      // Persiste as alterações
      _saveTasks();
    });
  }

  // ===== FUNÇÕES DE PERSISTÊNCIA =====

  /// Guarda todas as tarefas no armazenamento local
  ///
  /// Serializa a lista de tarefas para JSON e guarda usando SharedPreferences
  ///
  /// Retorna um Future que completa quando o salvamento termina
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();

    // Converte cada Task para Map
    final tasksJson = _tasks.map((task) => task.toJson()).toList();

    // Converte lista de Maps para String JSON
    final tasksString = jsonEncode(tasksJson);

    // Guarda no SharedPreferences
    await prefs.setString('tasks', tasksString);
    print('💾 Tarefas guardadas: ${_tasks.length} tarefas');
  }

  /// Carrega as tarefas do armazenamento local
  ///
  /// Deserializa o JSON guardado e reconstrói a lista de tarefas
  /// Se não houver tarefas guardadas, mantém a lista vazia
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString('tasks');

    // Se não houver dados guardados, retorna
    if (tasksString == null) {
      print('📭 Nenhuma tarefa guardada ainda');
      return;
    }

    // Converte String JSON para lista de Maps
    final List<dynamic> tasksJson = jsonDecode(tasksString);

    // Converte cada Map para Task
    final tasks = tasksJson.map((json) => Task.fromJson(json)).toList();

    setState(() {
      _tasks = tasks;
    });

    print('📂 Tarefas carregadas: ${_tasks.length} tarefas');
  }

  // ===== FUNÇÕES DE FILTRO E ESTATÍSTICAS =====

  /// Retorna lista de tarefas filtrada conforme o filtro atual
  ///
  /// Retorna:
  /// - Todas as tarefas se filtro = 'todas'
  /// - Apenas tarefas completas se filtro = 'completas'
  /// - Apenas tarefas incompletas se filtro = 'incompletas'
  List<Task> _obterTarefasFiltradas() {
    if (_filtroAtual == 'completas') {
      return _tasks.where((task) => task.isCompleted).toList();
    } else if (_filtroAtual == 'incompletas') {
      return _tasks.where((task) => !task.isCompleted).toList();
    } else {
      return _tasks;
    }
  }

  /// Calcula estatísticas das tarefas
  ///
  /// Retorna um Map contendo:
  /// - 'total': Número total de tarefas
  /// - 'completas': Número de tarefas completas
  /// - 'incompletas': Número de tarefas incompletas
  /// - 'percentagem': Percentagem de conclusão (0-100)
  Map<String, dynamic> _obterEstatisticas() {
    final total = _tasks.length;
    final completas = _tasks.where((task) => task.isCompleted).length;
    final incompletas = total - completas;
    final percentagem = total > 0 ? (completas / total * 100).toInt() : 0;

    return {
      'total': total,
      'completas': completas,
      'incompletas': incompletas,
      'percentagem': percentagem,
    };
  }

  // ===== FUNÇÕES DE INTERFACE (DIALOGS) =====

  /// Mostra dialog de confirmação antes de apagar uma tarefa
  ///
  /// [context]: BuildContext necessário para mostrar o dialog
  ///
  /// Retorna:
  /// - true se o utilizador confirmar a exclusão
  /// - false se o utilizador cancelar
  /// - null se fechar sem escolher
  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar'),
          content: const Text('Tens certeza que queres apagar esta tarefa?'),
          actions: [
            // Botão Cancelar
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            // Botão Apagar
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Apagar'),
            ),
          ],
        );
      },
    );
  }

  /// Mostra dialog para adicionar uma nova tarefa
  ///
  /// Apresenta campos de texto para título e descrição
  /// Valida entrada e adiciona a tarefa à lista
  void _showAddTaskDialog() {
    // Controladores para os campos de texto
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nova Tarefa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Campo do título
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  hintText: 'Ex: Estudar Flutter',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              // Campo da descrição
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Ex: Rever os apontamentos',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
            ],
          ),
          actions: [
            // Botão Cancelar
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            // Botão Adicionar
            FilledButton(
              onPressed: () {
                final title = titleController.text;
                final description = descriptionController.text;

                // Validação: título não pode estar vazio
                if (title.isEmpty) {
                  print('Erro: Título não pode ser vazio!');
                  return;
                }

                // Cria nova tarefa
                final newTask = Task(
                  id: (_tasks.length + 1).toString(),
                  title: title,
                  description:
                      description.isEmpty ? 'Sem descrição' : description,
                  isCompleted: false,
                );

                // Adiciona à lista
                setState(() {
                  _tasks.add(newTask);
                });

                // Guarda alterações
                _saveTasks();

                // Fecha o dialog
                Navigator.pop(context);
                print('✅ Tarefa adicionada: $title');
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  /// Mostra dialog para editar uma tarefa existente
  ///
  /// [index]: Posição da tarefa a ser editada
  ///
  /// Apresenta campos pré-preenchidos com os dados atuais
  /// Permite atualizar título e descrição
  void _showEditTaskDialog(int index) {
    final task = _tasks[index];

    // Controladores pré-preenchidos com valores atuais
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Tarefa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Campo do título
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  hintText: 'Ex: Estudar',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              // Campo da descrição
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Ex: Rever os apontamentos',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
            ],
          ),
          actions: [
            // Botão Cancelar
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            // Botão Salvar
            FilledButton(
              onPressed: () {
                final newTitle = titleController.text;
                final newDescription = descriptionController.text;

                // Validação: título não pode estar vazio
                if (newTitle.isEmpty) {
                  print('Erro: Título não pode ser vazio');
                  return;
                }

                // Cria tarefa atualizada mantendo ID e estado
                final updatedTask = Task(
                  id: task.id,
                  title: newTitle,
                  description:
                      newDescription.isEmpty ? 'Sem descrição' : newDescription,
                  isCompleted: task.isCompleted,
                );

                // Atualiza na lista
                setState(() {
                  _tasks[index] = updatedTask;
                });

                // Guarda alterações
                _saveTasks();

                // Fecha o dialog
                Navigator.pop(context);
                print('✏️ Tarefa editada: $newTitle');
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // ===== BUILD =====

  /// Constrói a interface da página
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
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

      // Corpo da página
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card de Estatísticas
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    final stats = _obterEstatisticas();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título
                        const Text(
                          '📊 Estatísticas',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Linha com números
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total: ${stats['total']}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              '✅ Completas: ${stats['completas']}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              '⭕ Incompletas: ${stats['incompletas']}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Percentagem
                        Text(
                          'Progresso: ${stats['percentagem']}%',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Barra de progresso
                        LinearProgressIndicator(
                          value: stats['total'] > 0
                              ? stats['completas'] / stats['total']
                              : 0,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.green,
                          ),
                          minHeight: 8,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Título da lista
            const Text(
              'Lista de Tarefas:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Botões de filtro
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterChip(
                  label: const Text('Todas'),
                  selected: _filtroAtual == 'todas',
                  onSelected: (bool selected) {
                    setState(() {
                      _filtroAtual = 'todas';
                    });
                  },
                ),
                FilterChip(
                  label: const Text('Completas'),
                  selected: _filtroAtual == 'completas',
                  onSelected: (bool selected) {
                    setState(() {
                      _filtroAtual = 'completas';
                    });
                  },
                ),
                FilterChip(
                  label: const Text('Incompletas'),
                  selected: _filtroAtual == 'incompletas',
                  onSelected: (bool selected) {
                    setState(() {
                      _filtroAtual = 'incompletas';
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Lista de tarefas
            Expanded(
              child: ListView.builder(
                itemCount: _obterTarefasFiltradas().length,
                itemBuilder: (context, index) {
                  final tarefasFiltradas = _obterTarefasFiltradas();
                  final task = tarefasFiltradas[index];

                  return Dismissible(
                    key: Key(task.id),
                    direction: DismissDirection.endToStart,
                    // Fundo vermelho ao deslizar
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    // Callback ao completar deslize
                    onDismissed: (direction) {
                      _deleteTask(index);
                    },
                    // Confirmação antes de apagar
                    confirmDismiss: (direction) async {
                      return await _showDeleteConfirmationDialog(context);
                    },
                    // Card da tarefa
                    child: TaskCard(
                      task: task,
                      onTap: () {
                        _toggleTaskCompletion(index);
                      },
                      onLongPress: () {
                        _showEditTaskDialog(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Botão flutuante de adicionar
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        tooltip: 'Adicionar Tarefa',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ============================================================================
/// TASK CARD WIDGET
/// ============================================================================
/// Widget reutilizável que representa um card de tarefa
///
/// Parâmetros:
/// - [task]: Objeto Task com os dados a exibir
/// - [onTap]: Callback para toque simples (toggle completo/incompleto)
/// - [onLongPress]: Callback para toque longo (editar tarefa)
/// ============================================================================

/// Widget de card para exibir uma tarefa
class TaskCard extends StatelessWidget {
  /// Tarefa a ser exibida
  final Task task;

  /// Callback executado ao tocar no card
  final VoidCallback onTap;

  /// Callback executado ao pressionar longamente o card
  final VoidCallback onLongPress;

  /// Construtor do TaskCard
  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Linha com ícone e título
              Row(
                children: [
                  // Ícone de status
                  Icon(
                    task.isCompleted
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: task.isCompleted ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  // Título da tarefa
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color:
                            task.isCompleted ? Colors.grey[600] : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Descrição
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: Text(
                  task.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
