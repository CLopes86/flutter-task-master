import 'package:flutter/material.dart';
import '../../models/task.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  // ===== LISTA DE TAREFAS =====
  // Esta lista guarda todas as tarefas da aplicação
  // O ListView.builder vai criar um Card para cada uma automaticamente!
  List<Task> _tasks = [
    // Tarefa 1
    const Task(
      id: '1',
      title: 'Aprender Flutter',
      description: 'Completar o tutorial de Flutter',
      isCompleted: false,
    ),

    // Tarefa 2
    const Task(
      id: '2',
      title: 'Fazer exercícios',
      description: '30 minutos de caminhada',
      isCompleted: true,
    ),

    // Tarefa 3
    const Task(
      id: '3',
      title: 'Ler um livro',
      description: 'Ler 20 páginas do livro de Dart',
      isCompleted: false,
    ),

    // ===== NOVAS TAREFAS =====
    // Adicionamos mais 4 tarefas para testar

    // Tarefa 4
    const Task(
      id: '4',
      title: 'Estudar para o exame',
      description: 'Rever os apontamentos de matemática',
      isCompleted: false,
    ),

    // Tarefa 5
    const Task(
      id: '5',
      title: 'Fazer compras',
      description: 'Comprar leite, pão e frutas',
      isCompleted: true,
    ),

    // Tarefa 6
    const Task(
      id: '6',
      title: 'Ligar à mãe',
      description: 'Perguntar como está',
      isCompleted: false,
    ),

    // Tarefa 7
    const Task(
      id: '7',
      title: 'Preparar jantar',
      description: 'Cozinhar massa com legumes',
      isCompleted: false,
    ),
  ];

  // ===== FUNÇÃO PARA MOSTRAR O DIALOG =====
  // Esta função é chamada quando clicamos no botão "+"
  // Mostra uma janela popup para adicionar uma nova tarefa
  void _showAddTaskDialog() {
    // Controladores para guardar o que o utilizador escreve
    // TextEditingController: Guarda e controla o texto de um campo
    final titleController = TextEditingController();
    final descrptionController = TextEditingController();

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
                  labelText: 'Titulo',
                  hintText: 'Ex:Estudar',
                  border: OutlineInputBorder(),
                ),

                // autofocus: Abre o teclado automaticamente
                autofocus: true,
              ),
              // Espaço entre os campos
              const SizedBox(height: 16),

              // ----- CAMPO DA DESCRIÇÃO -----
              TextField(
                controller: descrptionController,
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
                final description = descrptionController.text;

                // Passo 2: Validar - Verificar se o título não está vazio
                if (title.isEmpty) {
                  // Se estiver vazio, não fazemos nada
                  // Podíamos mostrar uma mensagem de erro aqui
                  print('Erro: Titulo não pode ser vazio!');
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
                setState(
                  () {
                    // .add(): Adiciona a tarefa ao final da lista
                    _tasks.add(newTask);
                  },
                );

                // Passo 5: Fechar o Dialog
                Navigator.pop(context);

                // Passo 6: Mostrar mensagem de sucesso
                print('✅ Tarefa adicionada: $title');
              },
              child: const Text('Adcionar'),
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
            const Text(
              // ===== TÍTULO =====
              'Lista de Tarefas:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // ===== LISTA DE TAREFAS =====
            // Expanded: Faz o widget ocupar todo o espaço disponível
            Expanded(
                child: ListView.builder(
              // itemCount: Quantos itens existem na lista?
              // Resposta: O tamanho da lista _tasks
              itemCount: _tasks.length,

              // itemBuilder: Como construir cada item?
              // Esta função é chamada para CADA tarefa
              //
              // Parâmetros:
              //   - context: Informação sobre onde o widget está
              //   - index: Posição atual (0, 1, 2, ...)
              //
              // Retorna: Um widget (no nosso caso, TaskCard)
              itemBuilder: (context, index) {
                // Pega a tarefa na posição 'index'
                final task = _tasks[index];

                // Retorna o TaskCard com essa tarefa
                return TaskCard(task: task);
              },
            ))
          ],
        ),
      ),
      // ===== FLOATING ACTION BUTTON (FAB) =====
      // Botão redondo que flutua no canto inferior direito
      // Usado para adicionar novas tarefas
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,

        // tooltip: Texto que aparece quando mantém o dedo pressionado
        tooltip: 'Adcionar Tarefa',

        child: const Icon(Icons.add),
      ),
    );
  }
}

/// ============================================================================
/// TASK CARD WIDGET
/// ============================================================================
/// Widget reutilizável que representa um Card de tarefa.
///
/// Este widget recebe uma tarefa (Task) e exibe as informações dela
/// num Card bonito e formatado.
///
/// Parâmetros:
///   - task: O objeto Task com os dados a exibir
/// ============================================================================
class TaskCard extends StatelessWidget {
  final Task task; // Propriedade que vai guardar a tarefa

  // Construtor - recebe a tarefa como parâmetro obrigatório
  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // Espaço vertical de 4 pixels
            const SizedBox(height: 4),

            // ===== DESCRIÇÃO =====
            Padding(
              // Padding à esquerda para alinhar com o texto (depois do ícone)
              padding: const EdgeInsets.only(left: 30),
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
    );
  }
}
