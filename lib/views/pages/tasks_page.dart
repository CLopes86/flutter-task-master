import 'package:flutter/material.dart';
import '../../models/task.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  // ===== LISTA DE TAREFAS =====
  // Esta lista guarda todas as tarefas da aplicação
  // As tarefas são carregadas do SharedPreferences no initState
  // e guardadas automaticamente quando há mudanças
  List<Task> _tasks = [];
  String _filtroAtual = 'todas';

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // ===== FUNÇÃO PARA ALTERNAR O ESTADO DA TAREFA =====
  // Esta função é chamada quando clicamos numa tarefa
  // Recebe o índice (posição) da tarefa na lista
  void _toggleTaskCompletion(int index) {
    setState(() {
      final oldTask = _tasks[index];

      final newTask = Task(
        id: oldTask.id,
        title: oldTask.title,
        description: oldTask.description,
        isCompleted: !oldTask.isCompleted,
      );

      _tasks[index] = newTask;

      // Debug: Mostra no console o que aconteceu
      print(
          '✅ Tarefa "${newTask.title}" agora está: ${newTask.isCompleted ? "COMPLETA" : "INCOMPLETA"}');
      _saveTasks();
    });
  }

  void _deleteTask(int index) {
    setState(() {
      final deletedTask = _tasks[index];
      _tasks.removeAt(index);
      print('🗑️ Tarefa "${deletedTask.title}" foi apagada');
      _saveTasks();
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = _tasks.map((task) => task.toJson()).toList();
    final tasksString = jsonEncode(tasksJson);

    await prefs.setString('task', tasksString);
    print('💾 Tarefas guardadas: ${_tasks.length} tarefas');
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString('task');
    if (tasksString == null) {
      print('📭 Nenhuma tarefa guardada ainda');
      return;
    }
    final List<dynamic> tasksJson = jsonDecode(tasksString);
    final tasks = tasksJson.map((json) => Task.fromJson(json)).toList();

    setState(() {
      _tasks = tasks;
    });
    print('📂 Tarefas carregadas: ${_tasks.length} tarefas');
  }

  List<Task> _obterTarefasFiltradas() {
    if (_filtroAtual == 'completas') {
      return _tasks.where((task) => task.isCompleted).toList();
    } else if (_filtroAtual == 'incompletas') {
      return _tasks.where((task) => !task.isCompleted).toList();
    } else {
      return _tasks;
    }
  }

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

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar'),
          content: const Text('Tens certeza que queres apagar esta tarefa?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
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

  // ===== FUNÇÃO PARA MOSTRAR O DIALOG =====
  // Esta função é chamada quando clicamos no botão "+"
  // Mostra uma janela popup para adicionar uma nova tarefa
  void _showAddTaskDialog() {
    // Controladores para guardar o que o utilizador escreve
    // TextEditingController: Guarda e controla o texto de um campo
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    // showDialog: Mostra uma janela popup
    showDialog(
      // context: Informação sobre onde estamos na app
      context: context,

      // builder: Como construir o Dialog
      builder: (context) {
        // AlertDialog: Um tipo de Dialog com título, conteúdo e botões
        return AlertDialog(
          // ===== TÍTULO DO DIALOG =====
          title: const Text('Nova tarefa'),

          // ===== CONTEÚDO DO DIALOG =====
          content: Column(
            // mainAxisSize: Ocupa só o espaço necessário (não a tela toda)
            mainAxisSize: MainAxisSize.min,

            children: [
              // ----- CAMPO DO TÍTULO -----
              TextField(
                // controller: Liga este campo ao titleController
                // Assim podemos ler o que o utilizador escreveu
                controller: titleController,

                // decoration: Como decorar o campo
                decoration: const InputDecoration(
                  labelText: 'Título',
                  hintText: 'Ex: Estudar',
                  border: OutlineInputBorder(),
                ),

                // autofocus: Abre o teclado automaticamente
                autofocus: true,
              ),
              // Espaço entre os campos
              const SizedBox(height: 16),

              // ----- CAMPO DA DESCRIÇÃO -----
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Ex: Rever os apontamentos',
                  border: OutlineInputBorder(),
                ),

                // maxLines: Permite escrever em várias linhas
                maxLines: 5,
              ),
            ],
          ),

          // ===== BOTÕES DO DIALOG =====
          actions: [
            // ----- BOTÃO CANCELAR -----
            TextButton(
              // onPressed: O que acontece quando clicamos
              onPressed: () {
                // Navigator.pop: Fecha o Dialog (volta atrás)
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),

            // ----- BOTÃO ADICIONAR -----
            FilledButton(
              onPressed: () {
                // Passo 1: Ler o que o utilizador escreveu
                final title = titleController.text;
                final description = descriptionController.text;

                // Passo 2: Validar - Verificar se o título não está vazio
                if (title.isEmpty) {
                  // Se estiver vazio, não fazemos nada
                  // Podíamos mostrar uma mensagem de erro aqui
                  print('Erro: Título não pode ser vazio!');
                  return; // Sai da função sem fazer nada
                }

                // Passo 3: Criar a nova tarefa
                // Usamos Task(...) para criar um objeto Task novo
                final newTask = Task(
                  // id: Número único - usamos o tamanho da lista + 1
                  id: (_tasks.length + 1).toString(),

                  // title: O que o utilizador escreveu
                  title: title,

                  // description: O que o utilizador escreveu
                  // Se estiver vazio, usa uma descrição padrão
                  description:
                      description.isEmpty ? 'Sem descrição' : description,

                  // isCompleted: Novas tarefas começam incompletas
                  isCompleted: false,
                );

                // Passo 4: Adicionar à lista
                // setState: Avisa o Flutter que algo mudou
                // O Flutter vai redesenhar a interface
                setState(() {
                  // .add(): Adiciona a tarefa ao final da lista
                  _tasks.add(newTask);
                });
                _saveTasks();

                // Passo 5: Fechar o Dialog
                Navigator.pop(context);

                // Passo 6: Mostrar mensagem de sucesso
                print('✅ Tarefa adicionada: $title');
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      // ===== BODY: Conteúdo principal da página =====
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        // Column: Organiza widgets verticalmente
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== CARD DE ESTATÍSTICAS =====
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(builder: (context) {
                  final stats = _obterEstatisticas();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '📊 Estatísticas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
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
                      Text(
                        'Progresso: ${stats['percentagem']}%',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: stats['total'] > 0
                            ? stats['completas'] / stats['total']
                            : 0,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.green,
                        ),
                        minHeight: 8,
                      ),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              // ===== TÍTULO =====
              'Lista de Tarefas:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // ===== BOTÕES DE FILTRO =====
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
                  onSelected: (bool select) {
                    setState(() {
                      _filtroAtual = 'completas';
                    });
                  },
                ),
                FilterChip(
                  label: const Text('Incompletas'),
                  selected: _filtroAtual == 'incompletas',
                  onSelected: (bool select) {
                    setState(() {
                      _filtroAtual = 'incompletas';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ===== LISTA DE TAREFAS =====
            // Expanded: Faz o widget ocupar todo o espaço disponível
            Expanded(
              child: ListView.builder(
                // itemCount: Quantos itens existem na lista?
                itemCount: _obterTarefasFiltradas().length,

                // itemBuilder: Como construir cada item?
                itemBuilder: (context, index) {
                  final tarefasFiltradas = _obterTarefasFiltradas();
                  final task = tarefasFiltradas[index];

                  // ===== DISMISSIBLE =====
                  // Widget que permite deslizar para apagar
                  return Dismissible(
                    // ===== KEY =====
                    // Cada Dismissible precisa de uma chave única
                    key: Key(task.id),

                    // ===== DIREÇÃO =====
                    // endToStart = da direita para esquerda (→ ←)
                    direction: DismissDirection.endToStart,

                    // ===== BACKGROUND =====
                    // O que aparece "atrás" quando deslizamos
                    background: Container(
                      // Cor vermelha (perigo)
                      color: Colors.red,

                      // Alinhamento à direita
                      alignment: Alignment.centerRight,

                      // Espaço interno
                      padding: const EdgeInsets.only(right: 20),

                      // Margem (igual ao card)
                      margin: const EdgeInsets.only(bottom: 8),

                      // Ícone de lixo
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),

                    // ===== ON DISMISSED =====
                    // Chamado quando completamos o deslize
                    onDismissed: (direction) {
                      _deleteTask(index);
                    },

                    // ===== CONFIRM DISMISS =====
                    // Chamado ANTES de apagar - mostra confirmação
                    confirmDismiss: (direction) async {
                      return await _showDeleteConfirmationDialog(context);
                    },

                    // ===== CHILD =====
                    // O TaskCard (o que vemos na tela)
                    child: TaskCard(
                      task: task,
                      onTap: () {
                        _toggleTaskCompletion(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ===== FLOATING ACTION BUTTON (FAB) =====
      // Botão redondo que flutua no canto inferior direito
      // Usado para adicionar novas tarefas
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,

        // tooltip: Texto que aparece quando mantém o dedo pressionado
        tooltip: 'Adicionar Tarefa',

        child: const Icon(Icons.add),
      ),
    );
  }
}

// ============================================================================
/// TASK CARD WIDGET
/// ============================================================================
/// Widget reutilizável que representa um Card de tarefa.
///
/// Este widget recebe uma tarefa (Task) e exibe as informações dela
/// num Card bonito e formatado.
///
/// Parâmetros:
///   - task: O objeto Task com os dados a exibir
///   - onTap: Função que é chamada quando clicamos no card
/// ============================================================================
class TaskCard extends StatelessWidget {
  final Task task; // Propriedade que vai guardar a tarefa

  // Esta função será chamada quando clicarmos no card
  // VoidCallback = uma função que não retorna nada e não recebe parâmetros
  final VoidCallback onTap;

  // Construtor - recebe a tarefa como parâmetro obrigatório
  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ===== GESTURE DETECTOR =====
    // Detecta toques/cliques no card
    return GestureDetector(
      // onTap: Chama a função quando clicamos
      onTap: onTap,

      // child: O Card fica "dentro" do GestureDetector
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 8),

        // Filho: o conteúdo dentro do Card
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          // Column: organiza widgets verticalmente (um em cima do outro)
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== LINHA COM ÍCONE E TÍTULO =====
              Row(
                // Row: organiza widgets horizontalmente (lado a lado)
                children: [
                  // --- ÍCONE DE STATUS ---
                  Icon(
                    // Se a tarefa está completa, mostra check_circle
                    // Se não, mostra círculo vazio
                    task.isCompleted
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,

                    // Cor: verde se completa, cinza se não
                    color: task.isCompleted ? Colors.green : Colors.grey,
                  ),

                  // Espaço horizontal de 12 pixels entre o ícone e o título
                  const SizedBox(width: 12),

                  // --- TÍTULO DA TAREFA ---
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      // Riscar se completa
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      // Cor mais clara se completa
                      color: task.isCompleted ? Colors.grey[600] : Colors.black,
                    ),
                  ),
                ],
              ),

              // Espaço vertical de 4 pixels
              const SizedBox(height: 4),

              // ===== DESCRIÇÃO =====
              Padding(
                // Padding à esquerda para alinhar com o texto (depois do ícone)
                padding: const EdgeInsets.only(left: 36),
                child: Text(
                  task.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
